
IF OBJECT_ID (N'dbo.stp_UpdateUser', N'P') IS NOT NULL 
	DROP PROCEDURE dbo.stp_UpdateUser
GO

/* Version 1.0.0 - OhadP 01/04/2020 Initial Version */
/* Version 1.0.1 - OhadP 02/04/2020 MedicalCenterID and OrganizationID were added to @in_json */
/* Version 1.0.2 - OhadO 04/04/2020 fix issue with OrganizationID */
/* Version 1.0.3 - OhadP 04/04/2020 add SELECT @out_json, default was added to @out_json and it's not required */

/*
@in_json format:	
	{
		"userid": "2",
		"firstname": "John", 
		"lastname": "Doe",
		"identitynumber": "365546511",
		"active": 1,
		"medicalcenterid": "",
		"organizationid": ""
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
	1016 - medical center id not exists on dbo.MedicalCenters table
	1017 - organization id not exists on combo data


Remark: this procedure will not change the user password
Remark: changing user name is not possible
*/

CREATE PROCEDURE dbo.stp_UpdateUser 
		@in_json	NVARCHAR(max),
		@out_json	NVARCHAR(max) = NULL OUTPUT

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
	DECLARE @MedicalCenterID	int
	DECLARE @OrganizationID		int

	SELECT	@UserID				= UserID,
			@FirstName			= FirstName,
			@LastName			= LastName,
			@IdentityNumber		= IdentityNumber,
			@Active				= Active,
			@MedicalCenterID	= MedicalCenterID,
			@OrganizationID		= OrganizationID
	FROM	OPENJSON(@in_json)
	WITH (
			UserID				int					'$.userid',
			FirstName			nvarchar(200)		'$.firstname',
			LastName			nvarchar(200)		'$.lastname',
			IdentityNumber		nvarchar(40)		'$.identitynumber',
			Active				tinyint				'$.active',
			MedicalCenterID		int					'$.medicalcenterid',
			OrganizationID		int					'$.organizationid'
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

	IF @ErrorNo = 0 AND 
	   @MedicalCenterID > 0 AND
	   NOT EXISTS (	SELECT	1
					FROM	dbo.MedicalCenters
					WHERE	MedicalCenterID = @MedicalCenterID)
		-- medical center id not exists on dbo.MedicalCenters table
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
			UPDATE	dbo.Users
			SET		FirstName		= @FirstName,
					LastName		= @LastName,
					IdentityNumber	= @IdentityNumber,
					Active			= ISNULL (@Active, Active),
					UpdateDate		= getdate(),
					MedicalCenterID	= @MedicalCenterID,
					OrganizationID	= @OrganizationID
			WHERE	UserID			= @UserID
		END TRY
		BEGIN CATCH
			-- general error, cannot inserts row to dbo.Users table
			SET @ErrorNo = 1001
		END CATCH
	END		-- IF @ErrorNo = 0

	/********************************************************************************************************************/

	SET @out_json = '{ "userid": "' + ISNULL (CONVERT (nvarchar(30), @UserID), 'null') + '", "errorno": "' + ISNULL (CONVERT (nvarchar(30), @ErrorNo), 'null') + '" }'

	SELECT	@out_json

END