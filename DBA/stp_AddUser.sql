
IF OBJECT_ID (N'dbo.stp_AddUser', N'P') IS NOT NULL 
	DROP PROCEDURE dbo.stp_AddUser
GO

/* Version 1.0.0 - OhadP 29/03/2020 Initial Version */
/* Version 1.0.1 - OhadP 01/04/2020 Minor changes, fix errono details */
/* Version 1.0.2 - OhadP 02/04/2020 MedicalCenterID and OrganizationID were added to @in_json */
/* Version 1.0.3 - OhadP 04/04/2020 add SELECT @out_json, default was added to @out_json and it's not required */

/*
@in_json format:	
	{
		"firstname": "John", 
		"lastname": "Doe",
		"identitynumber": "365546511",
		"username": "johnd",
		"passwordhash": "hjjkhwkrhwrkwnfsd3424233fs9ferwlmlf",
		"passwordsalt": "srwlkfsd094sfs4342lfds",
		"medicalcenterid": "",
		"organizationid": ""
	}

@out_json format:
	{ 
		"userid": "2", 
		"errorno": "0" 
	}

errorno values:
	1000 - general error, cannot inserts row to dbo.Users table
	1010 - user name already exists on dbo.Users table
	1011 - identity number already exists on dbo.Users table (cannot assign sqme identity number to two users)
	1016 - medical center id not exists on dbo.MedicalCenters table
	1017 - organization id not exists on combo data
*/

CREATE PROCEDURE dbo.stp_AddUser 
		@in_json	NVARCHAR(max),
		@out_json	NVARCHAR(max) = NULL OUTPUT

AS
BEGIN

	/********************************************************************************************************************/
	
	-- local parameters
	DECLARE @UserID				int = NULL
	DECLARE @ErrorNo			int = 0

	-- gets data from json string

	DECLARE @FirstName			nvarchar(200)
	DECLARE @LastName			nvarchar(200)
	DECLARE @IdentityNumber		nvarchar(40)
	DECLARE @UserName			nvarchar(200)
	DECLARE @PasswordHash		nvarchar(400)
	DECLARE @PasswordSalt		nvarchar(400)
	DECLARE @MedicalCenterID	int
	DECLARE @OrganizationID		int


	SELECT	@FirstName			= FirstName,
			@LastName			= LastName,
			@IdentityNumber		= IdentityNumber,
			@UserName			= UserName,
			@PasswordHash		= PasswordHash,
			@PasswordSalt		= PasswordSalt,
			@MedicalCenterID	= MedicalCenterID,
			@OrganizationID		= OrganizationID
	FROM	OPENJSON(@in_json)
	WITH (
			UserID				int					'$.userid',
			FirstName			nvarchar(200)		'$.firstname',
			LastName			nvarchar(200)		'$.lastname',
			IdentityNumber		nvarchar(40)		'$.identitynumber',
			UserName			nvarchar(200)		'$.username',
			PasswordHash		nvarchar(400)		'$.passwordhash',
			PasswordSalt		nvarchar(400)		'$.passwordsalt',
			MedicalCenterID		int					'$.medicalcenterid',
			OrganizationID		int					'$.organizationid'
	) AS jsonValues
	
	/********************************************************************************************************************/
	-- Check data

	IF @ErrorNo IS NULL
		SET @ErrorNo = 0

	IF EXISTS (	SELECT	1
				FROM	dbo.Users
				WHERE	UserName = @UserName)
		-- user name already exists on dbo.Users table
		SET @ErrorNo = 1010

	IF @ErrorNo = 0 AND
	   EXISTS (	SELECT	1
				FROM	dbo.Users
				WHERE	IdentityNumber = @IdentityNumber)
		-- identity number already exists on dbo.Users table (cannot assign sqme identity number to two users)
		SET @ErrorNo = 1011

	IF @ErrorNo = 0 AND
	   @MedicalCenterID > 0 AND	
	   NOT EXISTS (	SELECT	1
					FROM	dbo.MedicalCenters
					WHERE	MedicalCenterID = @MedicalCenterID)
		-- media center id not exists on dbo.MedicalCenters table
		SET @ErrorNo = 1016

	IF @ErrorNo = 0 AND 
	   @OrganizationID > 0 AND
	   NOT EXISTS (	SELECT	 1
					FROM	ComboData 
					WHERE	ComboDataDescription	= 'Organization'
					AND		ComboDataID				= @OrganizationID)
		-- organization id not exists on combo data
		SET @ErrorNo = 1017

	/********************************************************************************************************************/

	IF @ErrorNo = 0
	BEGIN
		BEGIN TRY
			INSERT INTO dbo.Users (
						FirstName,
						LastName,
						IdentityNumber,
						UserName,
						PasswordHash,
						PasswordSalt,
						PasswordLastChange,
						Active,
						MedicalCenterID,
						OrganizationID)
				SELECT	@FirstName,
						@LastName,
						@IdentityNumber,
						@UserName,
						CAST (@PasswordHash as varbinary(400)),
						CAST (@PasswordSalt as varbinary(400)),
						getdate(),
						1,
						@MedicalCenterID,
						@OrganizationID

			SET @UserID = SCOPE_IDENTITY()
		END TRY
		BEGIN CATCH
			-- general error, cannot inserts row to dbo.Users table
			SET @ErrorNo = 1000
		END CATCH
	END		-- IF @ErrorNo = 0

	/********************************************************************************************************************/

	SET @out_json = '{ "userid": "' + ISNULL (CONVERT (nvarchar(30), @UserID), 'null') + '", "errorno": "' + ISNULL (CONVERT (nvarchar(30), @ErrorNo), 'null') + '" }'

	SELECT	@out_json
END