-- Last Change 02/04/2020

DECLARE @out_json NVARCHAR(max)

DECLARE @json NVARCHAR(max)

SET @json = '{
				"medicalcenterid": "1",
				"medicalcenterdescription": "איכילוב",
				"street": "ויצמן",
				"streetnumber": "6",
				"city": "תל אביב יפו",
				"geolocation":"31.4062525,35.0818155"
			}'

EXEC dbo.stp_UpdateMedicalCenter 
		@in_json	= @json,
		@out_json	= @out_json OUTPUT

select @out_json out_json


select * from dbo.MedicalCenters



/**************************************************************************/

