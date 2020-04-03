IF COL_LENGTH('dbo.Users','MedicalCenterID') IS NULL
	ALTER TABLE dbo.Users
		ADD MedicalCenterID		int			NULL

IF COL_LENGTH('dbo.Users','OrganizationID') IS NULL
	ALTER TABLE dbo.Users
		ADD OrganizationID		int			NULL

-- drops the identity from dbo.Strings table
IF COLUMNPROPERTY(OBJECT_ID('dbo.Strings'),'StringID','IsIdentity') IS NOT NULL 
BEGIN
	DROP TABLE dbo.Strings	
END

IF OBJECT_ID (N'dbo.Strings', N'U') IS NULL 
	CREATE TABLE dbo.Strings (
		StringID				int				NOT NULL,
		LanguageID				smallint		NOT NULL,
		String					nvarchar(200)	NOT NULL,
		CONSTRAINT PK_Strings PRIMARY KEY(StringID, LanguageID),
		FOREIGN KEY (LanguageID) REFERENCES dbo.Languages (LanguageID)
	)

-- drops the identity from dbo.MedicalCentersNumOfPatients table
IF COLUMNPROPERTY(OBJECT_ID('dbo.MedicalCentersNumOfPatients'),'MedicalCenterID','IsIdentity') IS NOT NULL 
BEGIN
	DROP TABLE dbo.MedicalCentersNumOfPatients	
END

IF OBJECT_ID (N'dbo.MedicalCentersNumOfPatients', N'U') IS NULL 
	CREATE TABLE dbo.MedicalCentersNumOfPatients (
		MedicalCenterID				int				NOT NULL,
		DepartmentID				int				NOT NULL,
		Severity					int				NOT NULL,
		AvailableBeds				int				NOT NULL,
		OccupiedBeds				int				NOT NULL,
		VacantBeds AS AvailableBeds - OccupiedBeds,
		InsertDate					datetime		NOT NULL	DEFAULT (getdate()),
		UpdateDate					datetime		NOT NULL	DEFAULT (getdate()),
		CONSTRAINT PK_MedicalCentersNumOfPatients PRIMARY KEY(MedicalCenterID, Severity),
		FOREIGN KEY (MedicalCenterID) REFERENCES dbo.MedicalCenters (MedicalCenterID)
	)

IF COL_LENGTH('dbo.MedicalCenters','Active') IS NULL
	ALTER TABLE dbo.MedicalCenters
		ADD	Active		tinyint		NOT NULL	DEFAULT (1)

IF EXISTS (	SELECT	1
			FROM	sys.columns
			WHERE	name = 'City'
			AND		object_id = OBJECT_ID('dbo.MedicalCenters')
			AND		TYPE_NAME(system_type_id) = 'int')
	ALTER TABLE dbo.MedicalCenters
		ALTER COLUMN City	nvarchar(50)	NOT NULL

IF EXISTS (	SELECT	1
			FROM	sys.columns
			WHERE	name = 'StreetNumber'
			AND		object_id = OBJECT_ID('dbo.MedicalCenters')
			AND		is_nullable = 0)
	ALTER TABLE dbo.MedicalCenters
		ALTER COLUMN StreetNumber	nvarchar(10)	NULL

IF COL_LENGTH('dbo.MedicalCenters','GeoLocation') IS NULL
	ALTER TABLE dbo.MedicalCenters
		ADD	GeoLocation		nvarchar(200)		NULL

IF COL_LENGTH('dbo.MedicalCentersNumOfPatients','isER') IS NULL
	ALTER TABLE dbo.MedicalCentersNumOfPatients
		ADD	isER		tinyint		NOT NULL	DEFAULT (1)

IF COL_LENGTH('dbo.MedicalCentersNumOfPatients','BreadingMachines') IS NULL
	ALTER TABLE dbo.MedicalCentersNumOfPatients
		ADD	BreadingMachines	int		NULL
