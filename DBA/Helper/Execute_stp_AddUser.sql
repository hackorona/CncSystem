-- Last Change 02/04/2020

DECLARE @out_json NVARCHAR(max)

DECLARE @json NVARCHAR(max)
/*
SET @json = '{
				"firstname": "Ohad", 
				"lastname": "Pick",
				"identitynumber": "265546511",
				"username": "ohadp",
				"passwordhash": "hjjkhwkrhwrkwnfsd98fs9ferwlmlf",
				"passwordsalt": "srwlkfsd094sfslfds",
				"medicalcenterid": "",
				"organizationid": ""
			}'
*/
SET @json = '{
				"firstname": "Idit", 
				"lastname": "Ben",
				"identitynumber": "225548711",
				"username": "iditb",
				"passwordhash": "hjjkhwkrhwrkwnfsd3424233fs9ferwlmlf",
				"passwordsalt": "srwlkfsd094sfs4342lfds",
				"medicalcenterid": "1",
				"organizationid": ""
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

