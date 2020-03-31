DECLARE @out_json NVARCHAR(max)

DECLARE @json NVARCHAR(max)
/*
SET @json = '{
				"firstname": "Ohad", 
				"lastname": "Pick",
				"identitynumber": "265546511",
				"username": "ohadp",
				"passwordhash": "hjjkhwkrhwrkwnfsd98fs9ferwlmlf",
				"passwordsalt": "srwlkfsd094sfslfds"
			}'
*/
SET @json = '{
				"firstname": "John", 
				"lastname": "Doe",
				"identitynumber": "365546511",
				"username": "johnd",
				"passwordhash": "hjjkhwkrhwrkwnfsd3424233fs9ferwlmlf",
				"passwordsalt": "srwlkfsd094sfs4342lfds"
			}'

EXEC dbo.stp_AddUser 
		@in_json	= @json,
		@out_json	= @out_json OUTPUT

select @out_json out_json


select * from Users

/*

delete Users

DBCC CHECKIDENT ('dbo.Users', RESEED, 0);
GO

*/

/**************************************************************************/

