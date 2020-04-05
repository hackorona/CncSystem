
IF OBJECT_ID (N'dbo.stp_AddReservedBeds', N'P') IS NOT NULL 
	DROP PROCEDURE dbo.stp_AddReservedBeds
GO

/* Version 1.0.0 - OhadP 03/04/2020 Initial Version */
/* Version 1.0.1 - OhadP 04/04/2020 add SELECT @out_json, default was added to @out_json and it's not required */
/* Version 1.0.2 - OhadP 05/04/2020 add VentilationMachines column */

/*
@in_json format:	
	{
		"medicalcenterid": "1", 
		"departmentid": "3",
		"reserveventilationmachine": "1"
	}

@out_json format:
	{ 
		"errorno": "0" 
	}

errorno values:
	4000 - general error, cannot inserts row to dbo.MedicalCentersPatients table
	
*/

CREATE PROCEDURE dbo.stp_AddReservedBeds 
		@in_json	NVARCHAR(max),
		@out_json	NVARCHAR(max) = NULL OUTPUT

AS
BEGIN

	/********************************************************************************************************************/

	-- local parameters
	DECLARE @ErrorNo			int = 0

	-- gets data from json string

	DECLARE @MedicalCenterID		int
	DECLARE @DepartmentID			int
	DECLARE @VentilationMachines	tinyint

	SELECT	@MedicalCenterID		= MedicalCenterID,
			@DepartmentID			= DepartmentID,
			@VentilationMachines	= VentilationMachines
	FROM	OPENJSON(@in_json)
	WITH (
			MedicalCenterID			int			'$.medicalcenterid',
			DepartmentID			int			'$.departmentid',
			VentilationMachines		tinyint		'$.reserveventilationmachine'
	) AS jsonValues
	
	/********************************************************************************************************************/
	-- Check data

	IF @ErrorNo IS NULL
		SET @ErrorNo = 0

	IF NOT EXISTS (	SELECT	1
					FROM	dbo.MedicalCenters
					WHERE	MedicalCenterID = @MedicalCenterID)
		-- medical center id not exists on dbo.MedicalCenters table
		SET @ErrorNo = 1016

	IF @VentilationMachines IS NULL
		SET @VentilationMachines = 0

	/********************************************************************************************************************/

	IF @ErrorNo = 0
	BEGIN
		BEGIN TRY
			INSERT INTO dbo.ReservedBeds (
						MedicalCenterID,
						DepartmentID,
						VentilationMachines)
				SELECT	@MedicalCenterID,
						@DepartmentID,
						@VentilationMachines
		END TRY
		BEGIN CATCH
			-- general error, cannot inserts row to dbo.MedicalCentersPatients table
			SET @ErrorNo = 4000
		END CATCH
	END		-- IF @ErrorNo = 0

	/********************************************************************************************************************/

	SET @out_json = '{ "errorno": "' + ISNULL (CONVERT (nvarchar(30), @ErrorNo), 'null') + '" }'

	SELECT	@out_json
END