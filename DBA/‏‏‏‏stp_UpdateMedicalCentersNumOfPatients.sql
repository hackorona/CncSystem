
IF OBJECT_ID (N'dbo.stp_UpdateMedicalCentersNumOfPatients', N'P') IS NOT NULL 
	DROP PROCEDURE dbo.stp_UpdateMedicalCentersNumOfPatients
GO

/* Version 1.0.0 - OhadP 02/04/2020 Initial Version */

/*
@in_json format:	
	{
		"medicalcenterid": "2",
		"departmentid": "5",
		"severity": "1",
		"availablebeds": "100",
		"occupiedbeds": "76"
	}

@out_json format:
	{ 
		"medicalcenterid": "2", 
		"errorno": "0" 
	}

errorno values:
	3000 - general error, cannot inserts row to dbo.MedicalCenters table
	2011 - medical center id not exists on dbo.MedicalCenters table
*/

CREATE PROCEDURE dbo.stp_UpdateMedicalCentersNumOfPatients 
		@in_json	NVARCHAR(max),
		@out_json	NVARCHAR(max) OUTPUT

AS
BEGIN

	/********************************************************************************************************************/
	
	-- local parameters
	DECLARE @ErrorNo			int = 0

	-- gets data from json string

	DECLARE @MedicalCenterID	int 
	DECLARE @DepartmentID		int
	DECLARE @Severity			int
	DECLARE @AvailableBeds		int
	DECLARE @OccupiedBeds		int

	SELECT	@MedicalCenterID		= MedicalCenterID,
			@DepartmentID			= DepartmentID,
			@Severity				= Severity,
			@AvailableBeds			= AvailableBeds,
			@OccupiedBeds			= OccupiedBeds
	FROM	OPENJSON(@in_json)
	WITH (
			MedicalCenterID			int			'$.medicalcenterid',
			DepartmentID			int			'$.departmentid',
			Severity				int			'$.severity',
			AvailableBeds			int			'$.availablebeds',
			OccupiedBeds			int			'$.occupiedbeds'
	) AS jsonValues
	
	/********************************************************************************************************************/
	-- Check data

	IF @ErrorNo IS NULL
		SET @ErrorNo = 0

	IF NOT EXISTS (	SELECT	1
					FROM	dbo.MedicalCenters
					WHERE	MedicalCenterID = @MedicalCenterID)
		-- medical center id not exists on dbo.MedicalCenters table
		SET @ErrorNo = 2011

	/********************************************************************************************************************/

	IF @ErrorNo = 0
	BEGIN
		BEGIN TRY
			IF EXISTS (	SELECT	1
						FROM	dbo.MedicalCenters
						WHERE	MedicalCenterID = @MedicalCenterID)
			BEGIN
				-- Update existsing Data
				UPDATE	dbo.MedicalCentersNumOfPatients
				SET		DepartmentID			= @DepartmentID,
						Severity				= @Severity,
						AvailableBeds			= @AvailableBeds,
						OccupiedBeds			= @OccupiedBeds,
						UpdateDate				= getdate()
				WHERE	MedicalCenterID			= @MedicalCenterID
			END
			ELSE
			BEGIN
				-- Insert new row
				INSERT INTO dbo.MedicalCentersNumOfPatients (
							MedicalCenterID,
							DepartmentID,
							Severity,
							AvailableBeds,
							OccupiedBeds)
					SELECT	@MedicalCenterID,
							@DepartmentID,
							@Severity,
							@AvailableBeds,
							@OccupiedBeds
			END


			
		END TRY
		BEGIN CATCH
			-- general error, cannot inserts/updates row to MedicalCentersNumOfPatientstable
			SET @ErrorNo = 3000
		END CATCH
	END		-- IF @ErrorNo = 0

	/********************************************************************************************************************/

	SET @out_json = '{ "medicalcenterid": "' + ISNULL (CONVERT (nvarchar(30), @MedicalCenterID), 'null') + '", "errorno": "' + ISNULL (CONVERT (nvarchar(30), @ErrorNo), 'null') + '" }'

END