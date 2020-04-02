
IF OBJECT_ID (N'dbo.stp_UserNameExists', N'P') IS NOT NULL 
	DROP PROCEDURE dbo.stp_UserNameExists
GO

/* Version 1.0.0 - OhadP 01/04/2020 Initial Version */

/*
@in_json format:	
	{
		"username": "johnd"
	}

@out_json format:
	{ 
		"userid": "2", 
		"errorno": "0" 
	}

errorno values:
	
*/

CREATE PROCEDURE dbo.stp_UserNameExists 
		@in_json	NVARCHAR(max),
		@out_json	NVARCHAR(max) OUTPUT

AS
BEGIN

	/********************************************************************************************************************/
	
	-- local parameters
	DECLARE @UserID				int = NULL
	DECLARE @ErrorNo			int = 0

	-- gets data from json string

	DECLARE @UserName			 nvarchar(200)

	SELECT	@UserName		= UserName
	FROM	OPENJSON(@in_json)
	WITH (
			UserName			nvarchar(200)		'$.username'
	) AS jsonValues
	
	/********************************************************************************************************************/
	-- Check data

	IF @ErrorNo IS NULL
		SET @ErrorNo = 0

	/********************************************************************************************************************/

	SELECT	@UserID	= UserID
	FROM	dbo.Users
	WHERE	UserName = @UserName

	/********************************************************************************************************************/

	SET @out_json = '{ "userid": "' + ISNULL (CONVERT (nvarchar(30), @UserID), 'null') + '", "errorno": "' + ISNULL (CONVERT (nvarchar(30), @ErrorNo), 'null') + '" }'

END