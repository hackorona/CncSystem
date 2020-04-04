
IF OBJECT_ID (N'dbo.stp_GetMedicalCenters', N'P') IS NOT NULL 
	DROP PROCEDURE dbo.stp_GetMedicalCenters
GO

/* Version 1.0.1 - OhadP 02/04/2020 Initial Version */
/* Version 1.0.1 - OhadP 02/04/2020 GeoLocation was added */
/* Version 1.0.2 - OhadP 04/04/2020 add SELECT @out_json, default was added to @out_json and it's not required */
/* Version 1.0.3 - Ohadp 04/04/2020 MedicalCentersType column was added, adds summarize data from MedicalCentersNumOfPatients table
									for columns: AvailableBeds, OccupiedBeds, VacantBeds, VentilationMachines */

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
		"geolocation":"31.4062525,35.0818155",
		"medicalcenterstype": "1",
		"availablebeds": "240",
		"occupiedbeds": "195",
		"vacantbeds": "45",
		"ventilationmachines": "32"
	}

errorno values:
	
*/

CREATE PROCEDURE dbo.stp_GetMedicalCenters 
		@out_json	NVARCHAR(max) = NULL OUTPUT

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
				GeoLocation					geolocation,
				MedicalCentersType			medicalcenterstype,
				AvailableBeds				availablebeds,
				OccupiedBeds				occupiedbeds,
				VacantBeds					vacantbeds,
				VentilationMachines			ventilationmachines
		FROM	(
				SELECT	M.MedicalCenterID,
						M.MedicalCenterDescription,
						M.Street,
						M.StreetNumber,
						M.City,			
						M.InsertDate,
						M.UpdateDate,				
						M.Active,				
						M.GeoLocation,
						M.MedicalCentersType,
						P.AvailableBeds,		
						P.OccupiedBeds,			
						P.VacantBeds,			
						P.VentilationMachines		
				FROM	dbo.MedicalCenters M LEFT JOIN (
						SELECT	MedicalCenterID					MedicalCenterID,
								SUM (AvailableBeds)				AvailableBeds,
								SUM (OccupiedBeds)				OccupiedBeds,
								SUM (VacantBeds)				VacantBeds,
								SUM (VentilationMachines)		VentilationMachines
						FROM	dbo.MedicalCentersNumOfPatients
						GROUP BY MedicalCenterID
				) P
				ON		M.MedicalCenterID = P.MedicalCenterID
		) A
		FOR JSON AUTO
	)

	SELECT	@out_json

END