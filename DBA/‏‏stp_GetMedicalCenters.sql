
IF OBJECT_ID (N'dbo.stp_GetMedicalCenters', N'P') IS NOT NULL 
	DROP PROCEDURE dbo.stp_GetMedicalCenters
GO

/* Version 1.0.1 - OhadP 02/04/2020 Initial Version */
/* Version 1.0.1 - OhadP 02/04/2020 GeoLocation was added */

/*

@out_json format:
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

errorno values:
	
*/

CREATE PROCEDURE dbo.stp_GetMedicalCenters 
		@out_json	NVARCHAR(max) OUTPUT

AS
BEGIN

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
		FOR JSON AUTO
	)

END