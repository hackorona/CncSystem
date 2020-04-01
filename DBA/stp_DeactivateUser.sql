
IF OBJECT_ID (N'dbo.stp_DeactivateUser', N'P') IS NOT NULL 
	DROP PROCEDURE dbo.stp_DeactivateUser
GO

/* Version 1.0.0 - OhadP 01/04/2020 Initial Version */

/*
@in_json format:	
	{
		"userid": "12" 
	}

@out_json format:
	{ 
		"userid": "12", 
		"errorno": "0" 
	}

errorno values:
	1001 - general error, cannot update row on dbo.Users table
	1012 - the user id not exists on dbo.Users table
*/

CREATE PROCEDURE dbo.stp_DeactivateUser 
		@in_json	NVARCHAR(max),
		@out_json	NVARCHAR(max) OUTPUT

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

	IF @ErrorNo = 0
	BEGIN
		BEGIN TRY
			UPDATE	dbo.Users
			SET		Active		= 0,
					UpdateDate	= getdate()
			WHERE	UserID		= @UserID
		END TRY
		BEGIN CATCH
			-- general error, cannot update row on dbo.Users table
			SET @ErrorNo = 1001
		END CATCH
	END		-- IF @ErrorNo = 0

	/********************************************************************************************************************/

	SET @out_json = '{ "userid": "' + ISNULL (CONVERT (nvarchar(30), @UserID), 'null') + '", "errorno": "' + ISNULL (CONVERT (nvarchar(30), @ErrorNo), 'null') + '" }'

END