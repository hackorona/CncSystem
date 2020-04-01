DECLARE @out_json NVARCHAR(max)

DECLARE @in_json NVARCHAR(max)

SET @in_json = '{
					"userid": "2"
				}'


EXEC dbo.stp_ActivateUser 
		@in_json	= @in_json,
		@out_json	= @out_json OUTPUT

select @out_json out_json


select * from dbo.Users



/**************************************************************************/

