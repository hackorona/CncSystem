-- Last Change 04/04/2020

DECLARE @out_json NVARCHAR(max)

DECLARE @json NVARCHAR(max)

SET @json = '{
				"medicalcenterdescription": "�������",
				"street": "�����",
				"streetnumber": "6",
				"city": "�� ���� ���",
				"geolocation":"31.4062525,35.0818155",
				"medicalcenterstype": "1"
			}'
/*
SET @json = '{
				"medicalcenterdescription": "������",
				"street": "���� ����",
				"streetnumber": "16",
				"city": "�����",
				"geolocation":"",
				"medicalcenterstype": "1"
			}'
*/
/*
SET @json = '{
				"medicalcenterdescription": "�� ������ �� ����",
				"street": "������� ������ ������",
				"streetnumber": "10",
				"city": "�� ���� ���",
				"geolocation":"",
				"medicalcenterstype": "2"
			}'
*/



EXEC dbo.stp_AddMedicalCenter 
		@in_json	= @json,
		@out_json	= @out_json OUTPUT

select @out_json out_json


select * from dbo.MedicalCenters

/*

delete MedicalCenters

DBCC CHECKIDENT ('dbo.MedicalCenters', RESEED, 0);
GO

*/

/**************************************************************************/

