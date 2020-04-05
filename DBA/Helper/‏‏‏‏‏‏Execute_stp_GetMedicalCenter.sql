-- Last Change 02/04/2020

DECLARE @out_json NVARCHAR(max)

DECLARE @in_json NVARCHAR(max)

SET @in_json = '{
					"medicalcenterid": "1"
				}'
/*
SET @in_json = '{
					"medicalcenterid": "90"
				}'
*/

EXEC dbo.stp_GetMedicalCenter
		@in_json	= @in_json,
		@out_json	= @out_json OUTPUT

select @out_json out_json


-- select * from dbo.Users



/**************************************************************************/

