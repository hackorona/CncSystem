
IF OBJECT_ID (N'dbo.stp_GetUser', N'P') IS NOT NULL 
	DROP PROCEDURE dbo.stp_GetUser
GO

/* Version 1.0.0 - OhadP 01/04/2020 Initial Version */
/* Version 1.0.1 - OhadP 02/04/2020 MedicalCenterID and OrganizationID were added to @out_json */
/* Version 1.0.2 - OhadP 04/04/2020 add SELECT @out_json, default was added to @out_json and it's not required */
/* Version 1.0.3 - OhadP 04/04/2020 add UserRole column */

/*
@in_json format:	
	{
		"userid": "12" 
	}

@out_json format:
-- Good (user exists)
	{ 
		"userid": "2", 
		"firstname": "john",
		"lastname": "doe",
		"identitynumber": "123456789",
		"username": "johnd",
		"active": "1",
		"insertdate": "2020-03-30T22:49:05.800",
		"updatedate": "2020-03-30T22:49:05.800",
		"medicalcenterid": "null",					-- if null, will no be displayed
		"organizationid": "null",					-- if null, will no be displayed
		"userrole": "Doctor"
	}

-- User not exists
	{ 
		"userid": "2", 
		"errorno": "1012" 
	}

errorno values:
	1012 - the user id not exists on dbo.Users table
*/

CREATE PROCEDURE dbo.stp_GetUser
		@in_json	NVARCHAR(max),
		@out_json	NVARCHAR(max) = NULL OUTPUT

AS
BEGIN
	/********************************************************************************************************************/
	
	-- local parameters
	DECLARE @ErrorNo			int = 0

	-- gets data from json string

	DECLARE @UserID				int

	SELECT	@UserID		= UserID
	FROM	OPENJSON(@in_json)
	WITH (
			UserID				int		'$.userid'
	) AS jsonValues
	
	/********************************************************************************************************************/
	-- Check data

	IF @ErrorNo IS NULL
		SET @ErrorNo = 0

	IF NOT EXISTS (	SELECT	1
					FROM	dbo.Users
					WHERE	UserID = @UserID)
		-- the user id not exists on dbo.Users table
		SET @ErrorNo = 1012

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
				OrganizationID		organizationid,
				UserRole			userrole
		FROM	dbo.Users  
		WHERE	UserID = @UserID
		FOR JSON AUTO
	)

	/********************************************************************************************************************/
	
	IF @out_json IS NULL
		SET @out_json = '{ "userid": "' + ISNULL (CONVERT (nvarchar(30), @UserID), 'null') + '", "errorno": "' + ISNULL (CONVERT (nvarchar(30), @ErrorNo), 'null') + '" }'

	SELECT	@out_json
END