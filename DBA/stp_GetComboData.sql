
IF OBJECT_ID (N'dbo.stp_GetComboData', N'P') IS NOT NULL 
	DROP PROCEDURE dbo.stp_GetComboData
GO

/* Version 1.0.0 - OhadP 02/04/2020 Initial Version */
/* Version 1.0.1 - OhadP 04/04/2020 add SELECT @out_json, default was added to @out_json and it's not required */

/*
@in_json format:	
	{
		"combodatadescription": "severity", 
		"languageid": "1"
	}

@out_json format:
	{ 
		[
			"id": "1", 
			"string": "Easy" 
		],
		[
			"id": "2", 
			"string": "Medium" 
		],
		[
			"id": "3", 
			"string": "Severe" 
		],

	}

errorno values:
	5010 - combo data description does not exists on dbo.ComboData table
*/

CREATE PROCEDURE dbo.stp_GetComboData 
		@in_json	NVARCHAR(max),
		@out_json	NVARCHAR(max) = NULL OUTPUT

AS
BEGIN

	/********************************************************************************************************************/
	
	-- local parameters
	DECLARE @ErrorNo			int = 0

	-- gets data from json string

	DECLARE @ComboDataDescription		nvarchar(100)
	DECLARE @LanguageID					smallint
	
	SELECT	@ComboDataDescription	= LOWER (ComboDataDescription),
			@LanguageID				= LanguageID
	FROM	OPENJSON(@in_json)
	WITH (
			ComboDataDescription	nvarchar(100)	'$.combodatadescription',
			LanguageID				smallint		'$.languageid'
	) AS jsonValues
	
	/********************************************************************************************************************/
	-- Check data

	IF @ErrorNo IS NULL
		SET @ErrorNo = 0

	IF NOT EXISTS (	SELECT	1
					FROM	dbo.ComboData
					WHERE	LOWER (ComboDataDescription)	= @ComboDataDescription)
		-- combo data description does not exists on dbo.ComboData table
		SET @ErrorNo = 5010

	/********************************************************************************************************************/

	IF @ErrorNo = 0
	BEGIN
		SET @out_json = (
			SELECT	ComboDataID			combodataid,
					String				string
			FROM	(
					SELECT	D.ComboDataID			combodataid,
							S.String				string
					FROM	dbo.ComboData D INNER JOIN Strings S
					ON		D.StringID				= S.StringID
					WHERE	LOWER (ComboDataDescription)	= @ComboDataDescription
					AND		S.LanguageID					= @LanguageID
			) A
			FOR JSON AUTO
		) 
	END

	/********************************************************************************************************************/

	IF @out_json IS NULL
		SET @out_json = '{ "errorno": "' + ISNULL (CONVERT (nvarchar(30), @ErrorNo), 'null') + '" }'

	SELECT	@out_json

END