-- Last Change 02/04/2020

DECLARE @out_json NVARCHAR(max)

DECLARE @json NVARCHAR(max)

SET @json = '{
				"medicalcenterid": "1", 
				"departmentid": "3"
			}'
/*
SET @json = '{
				"medicalcenterid": "2", 
				"departmentid": "1"
			}'

SET @json = '{
				"medicalcenterid": "2", 
				"departmentid": "3"
			}'
*/
EXEC dbo.stp_AddReservedBeds 
		@in_json	= @json	/*,
		@out_json	= @out_json OUTPUT */

--select @out_json out_json


select * from dbo.ReservedBeds 

/*

delete Users

DBCC CHECKIDENT ('dbo.Users', RESEED, 0);
GO

*/

/**************************************************************************/

