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
				"firstname": "Moshe", 
				"lastname": "Davidi",
				"identitynumber": "56982335",
				"username": "moshed",
				"passwordhash": "hjjkhwkrhwrkgdlgdwnfsd3424233fs9ferwlmlf",
				"passwordsalt": "srwlkfsd094sfs434fsfs2lfds",
				"medicalcenterid": "1",
				"organizationid": "1"
			}'

EXEC dbo.stp_AddUser 
		@in_json	= @json /*,
		@out_json	= @out_json OUTPUT */


select * from Users

/*

delete Users

DBCC CHECKIDENT ('dbo.Users', RESEED, 0);
GO

*/

/**************************************************************************/

