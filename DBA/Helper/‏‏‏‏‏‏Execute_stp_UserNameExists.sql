DECLARE @out_json NVARCHAR(max)

DECLARE @in_json NVARCHAR(max)

SET @in_json = '{
					"username": "ohadp"
				}'
/*
SET @in_json = '{
					"username": "ohadp1"
				}'
*/

EXEC dbo.stp_UserNameExists 
		@in_json	= @in_json,
		@out_json	= @out_json OUTPUT

select @out_json out_json


select * from dbo.Users



/**************************************************************************/

