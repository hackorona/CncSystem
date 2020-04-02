
IF OBJECT_ID (N'dbo.stp_UpdateUserPassword', N'P') IS NOT NULL 
	DROP PROCEDURE dbo.stp_UpdateUserPassword
GO

/* Version 1.0.0 - OhadP 01/04/2020 Initial Version */

/*
@in_json format:	
	{
		"userid": "2",
		"passwordhash": "hjjkhwkrhwrkwnfsd3424233fs9ferwlmlf",
		"passwordsalt": "srwlkfsd094sfs4342lfds"
	}

@out_json format:
	{ 
		"userid": "2", 
		"errorno": "0" 
	}

errorno values:
	1001 - general error, cannot update row on dbo.Users table
	1012 - user id not exists on dbo.Users table
	1015 - password hash/password salt should not be empty

*/

CREATE PROCEDURE dbo.stp_UpdateUserPassword 
		@in_json	NVARCHAR(max),
		@out_json	NVARCHAR(max) OUTPUT

AS
BEGIN

	/********************************************************************************************************************/
	
	-- local parameters
	DECLARE @ErrorNo			int = 0

	-- gets data from json string

	DECLARE @UserID				int = NULL
	DECLARE @PasswordHash		 nvarchar(400)
	DECLARE @PasswordSalt		 nvarchar(400)

	SELECT	@UserID			= UserID,
			@PasswordHash	= PasswordHash,
			@PasswordSalt	= PasswordSalt
	FROM	OPENJSON(@in_json)
	WITH (
			UserID				int					'$.userid',
			PasswordHash		nvarchar(400)		'$.passwordhash',
			PasswordSalt		nvarchar(400)		'$.passwordsalt'
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

	IF @ErrorNo = 0 AND (LEN (LTRIM (RTRIM (@PasswordHash))) <= 0 OR LEN (LTRIM (RTRIM (@PasswordSalt))) <= 0)
		-- password hash/password salt should not be empty
		SET @ErrorNo = 1015

	/********************************************************************************************************************/

	IF @ErrorNo = 0
	BEGIN
		BEGIN TRY
			UPDATE	dbo.Users
			SET		PasswordHash		= CAST (@PasswordHash as varbinary(400)),
					PasswordSalt		= CAST (@PasswordSalt as varbinary(400)),
					PasswordLastChange	= getdate()
			WHERE	UserID				= @UserID
		END TRY
		BEGIN CATCH
			-- general error, cannot update row on dbo.Users table
			SET @ErrorNo = 1001
		END CATCH
	END		-- IF @ErrorNo = 0

	/********************************************************************************************************************/

	SET @out_json = '{ "userid": "' + ISNULL (CONVERT (nvarchar(30), @UserID), 'null') + '", "errorno": "' + ISNULL (CONVERT (nvarchar(30), @ErrorNo), 'null') + '" }'

END