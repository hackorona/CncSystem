-- Last Change 02/04/2020

DECLARE @out_json NVARCHAR(max)

DECLARE @in_json NVARCHAR(max)

SET @in_json = '{
					"medicalcenterid": "2",
					"departmentid": "",
					"severity": "1"
				}'
/*
SET @in_json = '{
					"medicalcenterid": "",
					"departmentid": "",
					"severity": ""
				}'

SET @in_json = '{
					"medicalcenterid": "1",
					"departmentid": "",
					"severity": ""
				}'

SET @in_json = '{
					"medicalcenterid": "",
					"departmentid": "2",
					"severity": ""
				}'

SET @in_json = '{
					"medicalcenterid": "",
					"departmentid": "",
					"severity": "2"
				}'
*/

SET @in_json = '{
					"medicalcenterid": "",
					"departmentid": "",
					"severity": ""
				}'

EXEC dbo.stp_GetMedicalCentersNumOfPatients 
		@in_json	= @in_json,
		@out_json	= @out_json OUTPUT

select @out_json out_json


/**************************************************************************/

