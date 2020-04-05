-- Last Change 05/04/2020

DECLARE @out_json NVARCHAR(max)

DECLARE @json NVARCHAR(max)

SET @json = '{
				"medicalcenterid": "2",
				"departmentid": "5",
				"severity": "1",
				"availablebeds": "100",
				"occupiedbeds": "78",
				"iser": "0",
				"availableventilationmachines": "5",
				"occupiedventilationmachines": "4"
			}'

/*
SET @json = '{
				"medicalcenterid": "2",
				"departmentid": "5",
				"severity": "2",
				"availablebeds": "126",
				"occupiedbeds": "89",
				"iser": "1",
				"availableventilationmachines": "12",
				"occupiedventilationmachines": "6"
			}'
*/
/*
SET @json = '{
				"medicalcenterid": "2",
				"departmentid": "5",
				"severity": "3",
				"availablebeds": "24",
				"occupiedbeds": "21",
				"iser": "1",
				"availableventilationmachines": "5",
				"occupiedventilationmachines": "5"
			}'
*/
/*
SET @json = '{
				"medicalcenterid": "1",
				"departmentid": "2",
				"severity": "3",
				"availablebeds": "24",
				"occupiedbeds": "21",
				"iser": "1",
				"availableventilationmachines": "15",
				"occupiedventilationmachines": "10"
			}'
*/

EXEC dbo.stp_UpdateMedicalCentersNumOfPatients 
		@in_json	= @json,
		@out_json	= @out_json OUTPUT

select @out_json out_json


select * from dbo.MedicalCentersNumOfPatients



/**************************************************************************/

