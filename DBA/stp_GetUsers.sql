
IF OBJECT_ID (N'dbo.stp_GetUsers', N'P') IS NOT NULL 
	DROP PROCEDURE dbo.stp_GetUsers
GO

/* Version 1.0.0 - OhadP 01/04/2020 Initial Version */
/* Version 1.0.1 - OhadP 02/04/2020 MedicalCenterID and OrganizationID were added to @out_json */
/* Version 1.0.2 - OhadP 04/04/2020 add SELECT @out_json, default was added to @out_json and it's not required */

/*

@out_json format:
	{ 
		"userid": "2", 
		"firstname": "john",
		"lastname": "doe",
		"identitynumber": "123456789",
		"username": "johnd",
		"active": "1",
		"insertdate": "2020-03-30T22:49:05.800",
		"updatedate": "2020-03-30T22:49:05.800",
		"medicalcenterid": "3",						-- if null, will no be displayed
		"organizationid": "2"							-- if null, will no be displayed
	}

errorno values:
	
*/

CREATE PROCEDURE dbo.stp_GetUsers 
		@out_json	NVARCHAR(max) = NULL OUTPUT

AS
BEGIN

	/********************************************************************************************************************/

	SET @out_json = (
		SELECT	UserID				userid,
				FirstName			firstname,
				LastName			lastname,
				IdentityNumber		identitynumber,
				UserName			username,
				Active				active,
				InsertDate			insertdate,
				UpdateDate			updatedate,
				MedicalCenterID		medicalcenterid,
				OrganizationID		organizationid
		FROM dbo.Users  
		FOR JSON AUTO
	)

	SELECT	@out_json

END