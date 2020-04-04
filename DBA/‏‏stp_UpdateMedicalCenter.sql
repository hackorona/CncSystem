
IF OBJECT_ID (N'dbo.stp_UpdateMedicalCenter', N'P') IS NOT NULL 
	DROP PROCEDURE dbo.stp_UpdateMedicalCenter
GO

/* Version 1.0.0 - OhadP 02/04/2020 Initial Version */
/* Version 1.0.1 - OhadP 02/04/2020 GeoLocation was added */
/* Version 1.0.2 - OhadP 04/04/2020 add SELECT @out_json, default was added to @out_json and it's not required */

/*
@in_json format:	
	{
		"medicalcenterid": "2",
		"medicalcenterdescription": "�������",
		"street": "�����",
		"streetnumber": "6",
		"city": "�� ���� ���",
		"active": "1",
		"geolocation": "31.4062525,35.0818155"
	}

@out_json format:
	{ 
		"medicalcenterid": "2", 
		"errorno": "0" 
	}

errorno values:
	2001 - general error, cannot inserts row to dbo.MedicalCenters table
	2010 - medical center description or street or city should not be empty
	2011 - medical center id not exists on dbo.MedicalCenters table
*/

CREATE PROCEDURE dbo.stp_UpdateMedicalCenter 
		@in_json	NVARCHAR(max),
		@out_json	NVARCHAR(max) = NULL OUTPUT

AS
BEGIN

	/********************************************************************************************************************/
	
	-- local parameters
	DECLARE @ErrorNo			int = 0

	-- gets data from json string

	DECLARE @MedicalCenterID			int 
	DECLARE @MedicalCenterDescription	nvarchar(200)
	DECLARE @Street						nvarchar(200)
	DECLARE @StreetNumber				nvarchar(20)
	DECLARE @City						nvarchar(100)
	DECLARE @Active						tinyint
	DECLARE @GeoLocation				nvarchar(200)

	SELECT	@MedicalCenterID			= MedicalCenterID,
			@MedicalCenterDescription	= MedicalCenterDescription,
			@Street						= Street,
			@StreetNumber				= StreetNumber,
			@City						= City,
			@Active						= Active,
			@GeoLocation				= GeoLocation
	FROM	OPENJSON(@in_json)
	WITH (
			MedicalCenterID				int					'$.medicalcenterid',
			MedicalCenterDescription	nvarchar(200)		'$.medicalcenterdescription',
			Street						nvarchar(200)		'$.street',
			StreetNumber				nvarchar(20)		'$.streetnumber',
			City						nvarchar(100)		'$.city',
			Active						tinyint				'$.active',
			GeoLocation					nvarchar(200)		'$.geolocation'
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

	IF @ErrorNo = 0 AND (LEN (LTRIM (RTRIM (@MedicalCenterDescription))) <= 0 OR LEN (LTRIM (RTRIM (@Street))) <= 0 OR LEN (LTRIM (RTRIM (@City))) <= 0)
		-- medical center description or street or city should not be empty
		SET @ErrorNo = 2010

	/********************************************************************************************************************/

	IF @ErrorNo = 0
	BEGIN
		BEGIN TRY
			UPDATE	dbo.MedicalCenters
			SET		MedicalCenterDescription	= @MedicalCenterDescription,
					Street						= @Street,
					StreetNumber				= @StreetNumber,
					City						= @City,
					UpdateDate					= getdate(),
					Active						= ISNULL (@Active, Active),
					GeoLocation					= @GeoLocation
			WHERE	MedicalCenterID				= @MedicalCenterID
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