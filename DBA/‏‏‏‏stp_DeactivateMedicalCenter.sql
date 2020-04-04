
IF OBJECT_ID (N'dbo.stp_DeactivateMedicalCenter', N'P') IS NOT NULL 
	DROP PROCEDURE dbo.stp_DeactivateMedicalCenter
GO

/* Version 1.0.0 - OhadP 02/04/2020 Initial Version */
/* Version 1.0.1 - OhadP 04/04/2020 add SELECT @out_json, default was added to @out_json and it's not required */

/*
@in_json format:	
	{
		"medicalcenterid": "12" 
	}

@out_json format:
	{ 
		"medicalcenterid": "2", 
		"errorno": "0" 
	}

errorno values:
	2001 - general error, cannot inserts row to dbo.MedicalCenters table
	2011 - medical center id not exists on dbo.MedicalCenters table
*/

CREATE PROCEDURE dbo.stp_DeactivateMedicalCenter 
		@in_json	NVARCHAR(max),
		@out_json	NVARCHAR(max) = NULL OUTPUT

AS
BEGIN

	/********************************************************************************************************************/
	
	-- local parameters
	DECLARE @ErrorNo			int = 0

	-- gets data from json string

	DECLARE @MedicalCenterID	int

	SELECT	@MedicalCenterID	= MedicalCenterID
	FROM	OPENJSON(@in_json)
	WITH (
			MedicalCenterID		int		'$.medicalcenterid'
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
			UPDATE	dbo.MedicalCenters
			SET		Active			= 0,
					UpdateDate		= getdate()
			WHERE	MedicalCenterID	= @MedicalCenterID
		END TRY
		BEGIN CATCH
			-- general error, cannot inserts row to dbo.MedicalCenters table
			SET @ErrorNo = 2001
		END CATCH
	END		-- IF @ErrorNo = 0

	/********************************************************************************************************************/

	SET @out_json = '{ "medicalcenterid": "' + ISNULL (CONVERT (nvarchar(30), @MedicalCenterID), 'null') + '", "errorno": "' + ISNULL (CONVERT (nvarchar(30), @ErrorNo), 'null') + '" }'

	SELECT	@out_json
END