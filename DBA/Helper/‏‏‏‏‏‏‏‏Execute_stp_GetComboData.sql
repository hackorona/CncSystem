-- Last Change 04/04/2020

DECLARE @out_json NVARCHAR(max)

DECLARE @in_json NVARCHAR(max)

SET @in_json = '{
					"combodatadescription": "MedicalCentersType", 
					"languageid": "1"
				}'
/*
SET @in_json = '{
					"combodatadescription": "Organization", 
					"languageid": "1"
				}'
*/
/*
SET @in_json = '{
					"combodatadescription": "Severity", 
					"languageid": "1"
				}'
*/

EXEC dbo.stp_GetComboData 
		@in_json	= @in_json,
		@out_json	= @out_json OUTPUT

select @out_json out_json


-- select * from dbo.ComboData





/**************************************************************************/
