/************************************************************************************************************/
/* Medical teams																							*/
/************************************************************************************************************/

/* Identity Number should be unique */
IF OBJECT_ID (N'dbo.Users', N'U') IS NULL 
	CREATE TABLE dbo.Users (
		UserID						int				IDENTITY (1,1),
		FirstName					nvarchar(100)	NOT NULL,
		LastName					nvarchar(100)	NOT NULL,
		IdentityNumber				nvarchar(20)	NOT NULL,
		UserName					nvarchar(100)	NOT NULL,
		PasswordHash				varbinary(400)	NOT NULL,
		PasswordSalt				varbinary(400)	NOT NULL,
		PasswordLastChange			datetime		NULL,
		Active						tinyint			NOT NULL	DEFAULT (1),
		InsertDate					datetime		NOT NULL	DEFAULT (getdate()),
		UpdateDate					datetime		NOT NULL	DEFAULT (getdate()),
		CONSTRAINT PK_Users PRIMARY KEY(UserID)
	)
ELSE
	print ('dbo.Users table already exists')

IF OBJECT_ID (N'dbo.Roles', N'U') IS NULL 
	CREATE TABLE dbo.Roles (
		RoleID						tinyint			IDENTITY (1,1),
		RoleDescription				nvarchar(100),
		InsertDate					datetime		NOT NULL	DEFAULT (getdate()),
		UpdateDate					datetime		NOT NULL	DEFAULT (getdate()),
		CONSTRAINT PK_Roles PRIMARY KEY(RoleID)
	)
ELSE
	print ('dbo.Roles table already exists')

/* Medical teams roles - for permissions */
IF OBJECT_ID (N'dbo.UsersRoles', N'U') IS NULL 
	CREATE TABLE dbo.UsersRoles (
		UserID						int,
		RoleID						tinyint,
		InsertDate					datetime		NOT NULL	DEFAULT (getdate()),
		UpdateDate					datetime		NOT NULL	DEFAULT (getdate()),
		CONSTRAINT PK_UsersRoles PRIMARY KEY(UserID, RoleID),
		FOREIGN KEY (UserID) REFERENCES dbo.Users (UserID),
		FOREIGN KEY (RoleID) REFERENCES dbo.Roles (RoleID)
	)
ELSE
	print ('dbo.UsersRoles table already exists')

-- permissions per role TBD!

/************************************************************************************************************/
/* Medical center																							*/
/************************************************************************************************************/

IF OBJECT_ID (N'dbo.MedicalCenters', N'U') IS NULL 
	CREATE TABLE dbo.MedicalCenters (
		MedicalCenterID				int				IDENTITY (1,1),
		MedicalCenterDescription	nvarchar(100)	NOT NULL,
		Street						nvarchar(100)	NOT NULL,
		StreetNumber				nvarchar(10)	NOT NULL,
		City						int				NOT NULL,
		InsertDate					datetime		NOT NULL	DEFAULT (getdate()),
		UpdateDate					datetime		NOT NULL	DEFAULT (getdate()),
		CONSTRAINT PK_MedicalCenters PRIMARY KEY(MedicalCenterID)
	)	
ELSE
	print ('dbo.MedicalCenters table already exists')

IF OBJECT_ID (N'dbo.MedicalCentersNumOfPatients', N'U') IS NULL 
	CREATE TABLE dbo.MedicalCentersNumOfPatients (
		MedicalCenterID				int				IDENTITY (1,1),
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
ELSE
	print ('dbo.MedicalCentersNumOfPatients table already exists')

/************************************************************************************************************/
/* Configuration																							*/
/************************************************************************************************************/

IF OBJECT_ID (N'dbo.Languages', N'U') IS NULL 
	CREATE TABLE dbo.Languages (
		LanguageID				smallint		IDENTITY (1,1),
		LanguageDescription		nvarchar(100)	NOT NULL,
		CONSTRAINT PK_Languages PRIMARY KEY(LanguageID)
	)
ELSE
	print ('dbo.Languages table already exists')

IF OBJECT_ID (N'dbo.Strings', N'U') IS NULL 
	CREATE TABLE dbo.Strings (
		StringID				int				IDENTITY (1,1),
		LanguageID				smallint		NOT NULL,
		String					nvarchar(200)	NOT NULL,
		CONSTRAINT PK_Strings PRIMARY KEY(StringID, LanguageID),
		FOREIGN KEY (LanguageID) REFERENCES dbo.Languages (LanguageID)
	)
ELSE
	print ('dbo.Strings table already exists')

IF OBJECT_ID (N'dbo.Dictionary', N'U') IS NULL 
	CREATE TABLE dbo.Dictionary (
		ValueToReplace			nvarchar(200)	NOT NULL,
		LanguageID				smallint		NOT NULL,
		NewValue				nvarchar(200)	NOT NULL,
		CONSTRAINT PK_Dictionary PRIMARY KEY(ValueToReplace, LanguageID),
		FOREIGN KEY (LanguageID) REFERENCES dbo.Languages (LanguageID)
	)
ELSE
	print ('dbo.Dictionary table already exists')

IF OBJECT_ID (N'dbo.ComboData', N'U') IS NULL 
	CREATE TABLE dbo.ComboData (
		ComboDataDescription	nvarchar(100)	NOT NULL,
		ComboDataID				smallint		NOT NULL,
		StringID				int				NOT NULL,
		CONSTRAINT PK_ComboData PRIMARY KEY(ComboDataDescription, ComboDataID)
	)
ELSE
	print ('dbo.ComboData table already exists')

/* 
	Severity
	ComboDataDescription		ComboDataID		StringID		String (from Strings table)
	Severity					1				200				Severe
	Severity					4				201				Medium
	Severity					3				202				Easy
*/

/************************************************************************************************************/
/* Data																										*/
/************************************************************************************************************/

/* Patients					*/
/* Identity Number should be unique */
IF OBJECT_ID (N'dbo.Patients', N'U') IS NULL 
	CREATE TABLE dbo.Patients (
		PatientID					int				IDENTITY (1,1),
		FirstName					nvarchar(100)	NOT NULL,
		LastName					nvarchar(100)	NOT NULL,
		IdentityNumber				nvarchar(20)	NOT NULL,
		InsertDate					datetime		NOT NULL	DEFAULT (getdate()),
		UpdateDate					datetime		NOT NULL	DEFAULT (getdate()),
		CONSTRAINT PK_Patients PRIMARY KEY(PatientID)
	)	
ELSE
	print ('dbo.Patients table already exists')

IF OBJECT_ID (N'dbo.PatientsLog', N'U') IS NULL 
	CREATE TABLE dbo.PatientsLog (
		LogDate						datetime		NOT NULL,
		PatientID					int				NOT NULL,
		Severity					int				NOT NULL,
		Remark						nvarchar(400)	NOT NULL,
		MedicalCenterID				int				NULL,
		DepartmentID				int				NULL,
		InsertDate					datetime		NOT NULL	DEFAULT (getdate()),
		UpdateDate					datetime		NOT NULL	DEFAULT (getdate()),
		CONSTRAINT PK_PatientsData PRIMARY KEY(LogDate desc,PatientID),
		FOREIGN KEY (PatientID) REFERENCES dbo.Patients (PatientID)
	)
ELSE
	print ('dbo.PatientsLog table already exists')



