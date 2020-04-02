
IF OBJECT_ID (N'dbo.stp_GetMedicalCentersNumOfPatients', N'P') IS NOT NULL 
	DROP PROCEDURE dbo.stp_GetMedicalCentersNumOfPatients
GO

/* Version 1.0.0 - OhadP 02/04/2020 Initial Version */

/*
@in_json format:	
	{
		"medicalcenterid": "2",
		"departmentid": "5",
		"severity": "1"
	}

@out_json format:
	{ 
		"medicalcenterid": "2",
		"departmentid": "5",
		"severity": "1",
		"availablebeds": "124",
		"occupiedbeds": "89",
		"vacantbeds": "35",
		"insertdate": "2020-03-30T22:49:05.800",
		"updatedate": "2020-03-30T22:49:05.800"
	}

errorno values:
	
*/

CREATE PROCEDURE dbo.stp_GetMedicalCentersNumOfPatients
		@in_json	NVARCHAR(max),
		@out_json	NVARCHAR(max) OUTPUT

AS
BEGIN
	/********************************************************************************************************************/
	
	-- local parameters
	DECLARE @ErrorNo			int = 0
	DECLARE @Sql				nvarchar(max)

	-- gets data from json string

	DECLARE @MedicalCenterID	int
	DECLARE @DepartmentID		int
	DECLARE @Severity			int

	SELECT	@MedicalCenterID	= MedicalCenterID,
			@DepartmentID		= DepartmentID,
			@Severity			= Severity
	FROM	OPENJSON(@in_json)
	WITH (
			MedicalCenterID		int		'$.medicalcenterid',
			DepartmentID		int		'$.departmentid',
			Severity			int		'$.severity'
	) AS jsonValues
	
	select @DepartmentID DepartmentID, @Severity Severity

	/********************************************************************************************************************/
	
	SET @Sql = N'
			SET @out_json = (
				SELECT	MedicalCenterID			medicalcenterid,
						DepartmentID			departmentid,
						Severity				severity,
						AvailableBeds			availablebeds,
						OccupiedBeds			occupiedbeds,
						VacantBeds				vacantbeds,
						InsertDate				insertdate,
						UpdateDate				updatedate
				FROM	dbo.MedicalCentersNumOfPatients  
				WHERE	1 = 1 ' + char(13)

		IF @DepartmentID > 0
			SET @Sql +=
			'	AND		MedicalCenterID	= @MedicalCenterID ' + char(13)

		IF @DepartmentID > 0
			SET @Sql +=
			'	AND		DepartmentID	= @DepartmentID ' + char(13)

		IF @Severity > 0
			SET @Sql +=
			'	AND		Severity	= @Severity ' + char(13)

		SET @Sql +=
			'	FOR JSON AUTO
			) '

	EXEC sp_executesql	@Sql, N'@out_json nvarchar(max) OUTPUT, @MedicalCenterID int, @DepartmentID int, @Severity int', 
						@out_json OUTPUT, @MedicalCenterID, @DepartmentID, @Severity

	/********************************************************************************************************************/
	
	IF @out_json IS NULL
		SET @out_json = '{ "medicalcenterid": "' + ISNULL (CONVERT (nvarchar(30), @MedicalCenterID), 'null') + '", "errorno": "' + ISNULL (CONVERT (nvarchar(30), @ErrorNo), 'null') + '" }'

END