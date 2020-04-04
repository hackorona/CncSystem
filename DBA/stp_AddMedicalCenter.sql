
IF OBJECT_ID (N'dbo.stp_AddMedicalCenter', N'P') IS NOT NULL 
	DROP PROCEDURE dbo.stp_AddMedicalCenter
GO

/* Version 1.0.0 - OhadP 02/04/2020 Initial Version */
/* Version 1.0.1 - OhadP 02/04/2020 GeoLocation was added */
/* Version 1.0.2 - OhadP 04/04/2020 add SELECT @out_json, default was added to @out_json and it's not required */
/* Version 1.0.3 - OhadP 04/04/2020 add MedicalCentersType column */

/*
@in_json format:	
	{
		"medicalcenterdescription": "איכילוב",
		"street": "ויצמן",
		"streetnumber": "6",
		"city": "תל אביב יפו"
		"geolocation":"31.4062525,35.0818155",
		"medicalcenterstype": "1"
	}

@out_json format:
	{ 
		"medicalcenterid": "2", 
		"errorno": "0" 
	}

errorno values:
	2000 - general error, cannot inserts row to dbo.Users table
	2010 - medical center description or street or city should not be empty
	2012 - medical center description already exists on dbo.MedicalCenters table
	2013 - medical centers type not exists in combo data
*/

CREATE PROCEDURE dbo.stp_AddMedicalCenter 
		@in_json	NVARCHAR(max),
		@out_json	NVARCHAR(max) = NULL OUTPUT

AS
BEGIN

	/********************************************************************************************************************/
	
	-- local parameters
	DECLARE @MedicalCenterID	int = NULL
	DECLARE @ErrorNo			int = 0

	-- gets data from json string

	DECLARE @MedicalCenterDescription	nvarchar(200)
	DECLARE @Street						nvarchar(200)
	DECLARE @StreetNumber				nvarchar(20)
	DECLARE @City						nvarchar(100)
	DECLARE @GeoLocation				nvarchar(200)
	DECLARE @MedicalCentersType			tinyint

	SELECT	@MedicalCenterDescription	= MedicalCenterDescription,
			@Street						= Street,
			@StreetNumber				= StreetNumber,
			@City						= City,
			@GeoLocation				= GeoLocation,
			@MedicalCentersType			= MedicalCentersType
	FROM	OPENJSON(@in_json)
	WITH (
			MedicalCenterDescription	nvarchar(200)		'$.medicalcenterdescription',
			Street						nvarchar(200)		'$.street',
			StreetNumber				nvarchar(20)		'$.streetnumber',
			City						nvarchar(100)		'$.city',
			GeoLocation					nvarchar(100)		'$.geolocation',
			MedicalCentersType			tinyint				'$.medicalcenterstype'
	) AS jsonValues
	
	/********************************************************************************************************************/
	-- Check data

	IF @ErrorNo IS NULL
		SET @ErrorNo = 0

	IF LEN (LTRIM (RTRIM (@MedicalCenterDescription))) <= 0 OR LEN (LTRIM (RTRIM (@Street))) <= 0 OR LEN (LTRIM (RTRIM (@City))) <= 0
		-- medical center description or street or city should not be empty
		SET @ErrorNo = 2010

	IF @ErrorNo = 0 AND
		EXISTS (SELECT	1
				FROM	dbo.MedicalCenters
				WHERE	MedicalCenterDescription = @MedicalCenterDescription)
		-- medical center description already exists on dbo.MedicalCenters table
		SET @ErrorNo = 2012

	IF @ErrorNo = 0 AND
		EXISTS (SELECT	1
				FROM	dbo.MedicalCenters
				WHERE	MedicalCenterDescription = @MedicalCenterDescription)
		-- medical center description already exists on dbo.MedicalCenters table
		SET @ErrorNo = 2012

	IF @ErrorNo = 0 AND
		@MedicalCentersType > 0 AND
		NOT EXISTS (SELECT	1
					FROM	dbo.ComboData
					WHERE	ComboDataDescription = 'MedicalCentersType'
					AND		ComboDataID			 = 	@MedicalCentersType)
		-- medical centers type not exists in combo data
		SET @ErrorNo = 2013

	/********************************************************************************************************************/

	IF @ErrorNo = 0
	BEGIN
		BEGIN TRY
			INSERT INTO dbo.MedicalCenters (
						MedicalCenterDescription,
						Street,
						StreetNumber,
						City,
						Active,
						GeoLocation,
						MedicalCentersType)
				SELECT	@MedicalCenterDescription,
						@Street,
						@StreetNumber,
						@City,
						1,
						@GeoLocation,
						@MedicalCentersType

			SET @MedicalCenterID = SCOPE_IDENTITY()
		END TRY
		BEGIN CATCH
			-- general error, cannot inserts row to dbo.MedicalCenters table
			SET @ErrorNo = 2000
		END CATCH
	END		-- IF @ErrorNo = 0

	/********************************************************************************************************************/

	SET @out_json = '{ "medicalcenterid": "' + ISNULL (CONVERT (nvarchar(30), @MedicalCenterID), 'null') + '", "errorno": "' + ISNULL (CONVERT (nvarchar(30), @ErrorNo), 'null') + '" }'
	
	SELECT	@out_json

END