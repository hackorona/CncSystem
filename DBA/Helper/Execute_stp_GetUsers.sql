
declare @out_json	NVARCHAR(max) 

EXEC dbo.stp_GetUsers 
	@out_json = @out_json OUTPUT

select @out_json


		