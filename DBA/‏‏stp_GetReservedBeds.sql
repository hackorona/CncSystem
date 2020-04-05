
IF OBJECT_ID (N'dbo.stp_GetReservedBeds', N'P') IS NOT NULL 
	DROP PROCEDURE dbo.stp_GetReservedBeds
GO

/* Version 1.0.0 - OhadP 03/04/2020 Initial Version */
/* Version 1.0.1 - OhadP 04/04/2020 add SELECT @out_json, default was added to @out_json and it's not required */
/* Version 1.0.2 - OhadP 05/04/2020 add VentilationMachines column, departmentid key was removed from @out_json format */

/*

@out_json format:
	{ 
		"medicalcenterid": "2",
		"reservedbeds": "3",
		"reservedventilationmachines": "3"
	}

errorno values:
	
*/

CREATE PROCEDURE dbo.stp_GetReservedBeds 
		@out_json	NVARCHAR(max) = NULL OUTPUT

AS
BEGIN

	DECLARE @ReserveBedHours		int
	SELECT	@ReserveBedHours = dbo.udf_GetSystemParameter ('ReserveBedHours', 4)
	
	/********************************************************************************************************************/

	SET @out_json = (
		SELECT	MedicalCenterID			medicalcenterid,
				ReservedBeds			reservedbeds,
				VentilationMachines		ventilationmachines
		FROM	(
				SELECT	MedicalCenterID,		
						ReservedBeds,
						VentilationMachines
				FROM	udf_ReservedBeds (@ReserveBedHours)
		) A
		ORDER BY MedicalCenterID
		FOR JSON AUTO
	)

	SELECT	@out_json

END