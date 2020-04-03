-- Last Change 03/04/2020

DECLARE @out_json NVARCHAR(max)

DECLARE @json NVARCHAR(max)

SET @json = '{
				"medicalcenterid": "2",
				"departmentid": "5",
				"severity": "1",
				"availablebeds": "100",
				"occupiedbeds": "78",
				"iser": 0,
				"breadingmachines": 5
			}'
/*
SET @json = '{
				"medicalcenterid": "2",
				"departmentid": "5",
				"severity": "2",
				"availablebeds": "126",
				"occupiedbeds": "89",
				"iser": 1,
				"breadingmachines": 4
			}'
*/
/*
SET @json = '{
				"medicalcenterid": "2",
				"departmentid": "5",
				"severity": "3",
				"availablebeds": "24",
				"occupiedbeds": "21",
				"iser": 1,
				"breadingmachines": 15
			}'
*/
/*
SET @json = '{
				"medicalcenterid": "1",
				"departmentid": "2",
				"severity": "3",
				"availablebeds": "24",
				"occupiedbeds": "21",
				"iser": 1,
				"breadingmachines": 15
			}'
*/

EXEC dbo.stp_UpdateMedicalCentersNumOfPatients 
		@in_json	= @json,
		@out_json	= @out_json OUTPUT

select @out_json out_json


select * from dbo.MedicalCentersNumOfPatients



/**************************************************************************/

