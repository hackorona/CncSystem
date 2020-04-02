
IF OBJECT_ID (N'dbo.stp_UpdateUser', N'P') IS NOT NULL 
	DROP PROCEDURE dbo.stp_UpdateUser
GO

/* Version 1.0.0 - OhadP 01/04/2020 Initial Version */

/*
@in_json format:	
	{
		"userid": "2",
		"firstname": "John", 
		"lastname": "Doe",
		"identitynumber": "365546511",
		"active": 1
	}

@out_json format:
	{ 
		"userid": "2", 
		"errorno": "0" 
	}

errorno values:
	1001 - general error, cannot update row on dbo.Users table
	1012 - user id not exists on dbo.Users table
	1013 - first Name/last Name should not be empty
	1014 - identity number should not be empty


Remark: this procedure will not change the user password
Remark: changing user name is not possible
*/

CREATE PROCEDURE dbo.stp_UpdateUser 
		@in_json	NVARCHAR(max),
		@out_json	NVARCHAR(max) OUTPUT

AS
BEGIN

	/********************************************************************************************************************/
	
	-- local parameters
	DECLARE @ErrorNo			int = 0

	-- gets data from json string

	DECLARE @UserID				int = NULL
	DECLARE @FirstName			nvarchar(200)
	DECLARE @LastName			nvarchar(200)
	DECLARE @IdentityNumber		nvarchar(40)
	DECLARE @UserName			nvarchar(200)
	DECLARE @Active				tinyint 

	SELECT	@UserID			= UserID,
			@FirstName		= FirstName,
			@LastName		= LastName,
			@IdentityNumber	= IdentityNumber,
			@Active			= Active
	FROM	OPENJSON(@in_json)
	WITH (
			UserID				int					'$.userid',
			FirstName			nvarchar(200)		'$.firstname',
			LastName			nvarchar(200)		'$.lastname',
			IdentityNumber		nvarchar(40)		'$.identitynumber',
			Active				tinyint				'$.active'
	) AS jsonValues
	
	/********************************************************************************************************************/
	-- Check data

	IF @ErrorNo IS NULL
		SET @ErrorNo = 0

	IF NOT EXISTS (	SELECT	1
					FROM	dbo.Users
					WHERE	UserID = @UserID)
		-- user id not exists on dbo.Users table
		SET @ErrorNo = 1012

	IF @ErrorNo = 0 AND (LEN (LTRIM (RTRIM (@FirstName))) <= 0 OR LEN (LTRIM (RTRIM (@LastName))) <= 0)
		-- first Name/last Name should not be empty
		SET @ErrorNo = 1013

	IF @ErrorNo = 0 AND LEN (LTRIM (RTRIM (@IdentityNumber))) <= 0
		-- identity number should not be empty
		SET @ErrorNo = 1014

	/********************************************************************************************************************/

	IF @ErrorNo = 0
	BEGIN
		BEGIN TRY
			UPDATE	dbo.Users
			SET		FirstName		= @FirstName,
					LastName		= @LastName,
					IdentityNumber	= @IdentityNumber,
					Active			= ISNULL (@Active, Active),
					UpdateDate		= getdate()
			WHERE	UserID			= @UserID
		END TRY
		BEGIN CATCH
			-- general error, cannot inserts row to dbo.Users table
			SET @ErrorNo = 1001
		END CATCH
	END		-- IF @ErrorNo = 0

	/********************************************************************************************************************/

	SET @out_json = '{ "userid": "' + ISNULL (CONVERT (nvarchar(30), @UserID), 'null') + '", "errorno": "' + ISNULL (CONVERT (nvarchar(30), @ErrorNo), 'null') + '" }'

END