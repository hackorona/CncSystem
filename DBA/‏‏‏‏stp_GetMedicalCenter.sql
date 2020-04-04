
IF OBJECT_ID (N'dbo.stp_GetMedicalCenter', N'P') IS NOT NULL 
	DROP PROCEDURE dbo.stp_GetMedicalCenter
GO

/* Version 1.0.0 - OhadP 02/04/2020 Initial Version */
/* Version 1.0.1 - OhadP 02/04/2020 GeoLocation was added */
/* Version 1.0.2 - OhadP 04/04/2020 add SELECT @out_json, default was added to @out_json and it's not required */

/*
@in_json format:	
	{
		"medicalcenterid": "2" 
	}

@out_json format:
-- Good (user exists)
	{ 
		"medicalcenterid": "2",
		"medicalcenterdescription": "איכילוב",
		"street": "ויצמן",
		"streetnumber": "6",
		"city": "תל אביב יפו",
		"insertdate": "2020-03-30T22:49:05.800",
		"updatedate": "2020-03-30T22:49:05.800",
		"active": 1,
		"geolocation":"31.4062525,35.0818155"
	}

-- User not exists
	{ 
		"medicalcenterid": "88", 
		"errorno": "2011" 
	}

errorno values:
	2011 - medical center id not exists on dbo.MedicalCenters table
*/

CREATE PROCEDURE dbo.stp_GetMedicalCenter
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

	SET @out_json = (
		SELECT	MedicalCenterID				medicalcenterid,
				MedicalCenterDescription	medicalcenterdescription,
				Street						street,
				StreetNumber				streetnumber,
				City						city,
				InsertDate					insertdate,
				UpdateDate					updatedate,
				Active						active,
				GeoLocation					geolocation
		FROM	dbo.MedicalCenters  
		WHERE	MedicalCenterID	= @MedicalCenterID
		FOR JSON AUTO
	)

	/********************************************************************************************************************/
	
	IF @out_json IS NULL
		SET @out_json = '{ "medicalcenterid": "' + ISNULL (CONVERT (nvarchar(30), @MedicalCenterID), 'null') + '", "errorno": "' + ISNULL (CONVERT (nvarchar(30), @ErrorNo), 'null') + '" }'

	SELECT	@out_json

END