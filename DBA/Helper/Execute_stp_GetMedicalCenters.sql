-- Last Change 02/04/2020

declare @out_json	NVARCHAR(max) 

EXEC dbo.stp_GetMedicalCenters 
	@out_json = @out_json OUTPUT

select @out_json


		