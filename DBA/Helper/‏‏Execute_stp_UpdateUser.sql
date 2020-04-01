DECLARE @out_json NVARCHAR(max)

DECLARE @json NVARCHAR(max)

SET @json = '{
				"userid": "2",
				"firstname": "John", 
				"lastname": "Doe",
				"identitynumber": "365546512",
				"active": 0
			}'
/*
SET @json = '{
				"userid": "2",
				"firstname": "John_1", 
				"lastname": "Doe_1",
				"identitynumber": "365546512",
				"active": 1
			}'
*/
EXEC dbo.stp_UpdateUser 
		@in_json	= @json,
		@out_json	= @out_json OUTPUT

select @out_json out_json


select * from dbo.Users


/**************************************************************************/

