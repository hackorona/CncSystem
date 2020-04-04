
IF object_id('dbo.udf_ReservedBeds', 'IF') IS NOT NULL
	DROP FUNCTION dbo.udf_ReservedBeds
GO

/* Version 1.0.0 - OhadP 03/04/2020 Initial Version */

/*
	@ReserveBedHours - how many hour to reserve beds
*/

CREATE FUNCTION dbo.udf_ReservedBeds (
		@ReserveBedHours		int = 0
)
RETURNS TABLE
AS
RETURN
    SELECT	MedicalCenterID				MedicalCenterID,
			DepartmentID				DepartmentID,
			ISNULL (COUNT (1), 0)		ReservedBeds
	FROM	dbo.ReservedBeds
	WHERE	DATEADD (hour, -@ReserveBedHours, getdate()) <= LogDate
	GROUP BY MedicalCenterID,
			DepartmentID

