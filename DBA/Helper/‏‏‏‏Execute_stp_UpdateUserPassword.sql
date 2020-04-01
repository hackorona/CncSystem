DECLARE @out_json NVARCHAR(max)

DECLARE @json NVARCHAR(max)

SET @json = '{
				"userid": "2",
				"passwordhash": "jsdefjlfs9fs92422jkljfwflmflse",
				"passwordsalt": "kfslkllkrm3423mreppo3emsty4"
			}'
/*
SET @json = '{
				"userid": "2",
				"passwordhash": "11",
				"passwordsalt": "22"
			}'
*/
EXEC dbo.stp_UpdateUserPassword 
		@in_json	= @json,
		@out_json	= @out_json OUTPUT

select @out_json out_json


select * from dbo.Users


/**************************************************************************/

