/************************************************************************************************************/
/* Medical teams																							*/
/************************************************************************************************************/

/* Identity Number should be unique */
IF OBJECT_ID (N'Users', N'U') IS NULL 
	CREATE TABLE Users (
		UserID						int				IDENTITY (1,1),
		FirstName					nvarchar(100)	NOT NULL,
		LastName					nvarchar(100)	NOT NULL,
		IdentityNumber				nvarchar(20)	NOT NULL,
		UserName					nvarchar(100)	NOT NULL,
		PasswordHash				varbinary(400)	NOT NULL,
		PasswordSalt				varbinary(400)	NOT NULL,
		PasswordLastChange			smalldatetime	NULL,
		Active						tinyint			NOT NULL	DEFAULT (1),
		CONSTRAINT PK_Users PRIMARY KEY(UserID)
	)
ELSE
	print ('Users table already exists')

IF OBJECT_ID (N'Roles', N'U') IS NULL 
	CREATE TABLE Roles (
		RoleID						tinyint			IDENTITY (1,1),
		RoleDescription				nvarchar(100),
		CONSTRAINT PK_Roles PRIMARY KEY(RoleID)
	)
ELSE
	print ('Roles table already exists')

/* Medical teams roles - for permissions */
IF OBJECT_ID (N'UsersRoles', N'U') IS NULL 
	CREATE TABLE UsersRoles (
		UserID						int,
		RoleID						tinyint,
		CONSTRAINT PK_UsersRoles PRIMARY KEY(UserID, RoleID),
		FOREIGN KEY (UserID) REFERENCES Users (UserID),
		FOREIGN KEY (RoleID) REFERENCES Roles (RoleID)
	)
ELSE
	print ('UsersRoles table already exists')

-- permissions per role TBD!

/************************************************************************************************************/
/* Patients																									*/
/************************************************************************************************************/

/* Patients					*/
/* Identity Number should be unique */
IF OBJECT_ID (N'Patients', N'U') IS NULL 
	CREATE TABLE Patients (
		PatientID					int				IDENTITY (1,1),
		FirstName					nvarchar(100)	NOT NULL,
		LastName					nvarchar(100)	NOT NULL,
		IdentityNumber				nvarchar(20)	NOT NULL,
		UserName					nvarchar(100)	NOT NULL,
		PasswordHash				varbinary(400)	NOT NULL,
		PasswordSalt				varbinary(400)	NOT NULL,
		PasswordLastChange			smalldatetime	NULL,
		CONSTRAINT PK_Patients PRIMARY KEY(PatientID)
	)	
ELSE
	print ('Patients table already exists')

/************************************************************************************************************/
/* Medical center																							*/
/************************************************************************************************************/

IF OBJECT_ID (N'MedicalCenters', N'U') IS NULL 
	CREATE TABLE MedicalCenters (
		MedicalCenterID				int				IDENTITY (1,1),
		MedicalCenterDescription	nvarchar(100)	NOT NULL,
		Street						nvarchar(100)	NOT NULL,
		StreetNumber				nvarchar(10)	NOT NULL,
		City						int				NOT NULL,
		CONSTRAINT PK_MedicalCenters PRIMARY KEY(MedicalCenterID)
	)	
ELSE
	print ('MedicalCenters table already exists')

IF OBJECT_ID (N'MedicalCentersNumOfPatients', N'U') IS NULL 
	CREATE TABLE MedicalCentersNumOfPatients (
		MedicalCenterID				int				IDENTITY (1,1),
		Severity					int				NOT NULL,
		AvailableBeds				int				NOT NULL,
		Occupied					int				NOT NULL,
		CONSTRAINT PK_MedicalCentersNumOfPatients PRIMARY KEY(MedicalCenterID, Severity),
		FOREIGN KEY (MedicalCenterID) REFERENCES MedicalCenters (MedicalCenterID)
	)	
ELSE
	print ('MedicalCentersNumOfPatients table already exists')

/************************************************************************************************************/
/* Configuration																							*/
/************************************************************************************************************/

IF OBJECT_ID (N'Languages', N'U') IS NULL 
	CREATE TABLE Languages (
		LanguageID				smallint		IDENTITY (1,1),
		LanguageDescription		nvarchar(100)	NOT NULL,
		CONSTRAINT PK_Languages PRIMARY KEY(LanguageID)
	)
ELSE
	print ('Languages table already exists')

IF OBJECT_ID (N'Strings', N'U') IS NULL 
	CREATE TABLE Strings (
		StringID				int				IDENTITY (1,1),
		LanguageID				smallint		NOT NULL,
		String					nvarchar(200)	NOT NULL,
		CONSTRAINT PK_Strings PRIMARY KEY(StringID, LanguageID),
		FOREIGN KEY (LanguageID) REFERENCES Languages (LanguageID)
	)
ELSE
	print ('Strings table already exists')

IF OBJECT_ID (N'Dictionary', N'U') IS NULL 
	CREATE TABLE Dictionary (
		ValueToReplace			nvarchar(200)	NOT NULL,
		LanguageID				smallint		NOT NULL,
		NewValue				nvarchar(200)	NOT NULL,
		CONSTRAINT PK_Dictionary PRIMARY KEY(ValueToReplace, LanguageID),
		FOREIGN KEY (LanguageID) REFERENCES Languages (LanguageID)
	)
ELSE
	print ('Dictionary table already exists')

IF OBJECT_ID (N'ComboData', N'U') IS NULL 
	CREATE TABLE ComboData (
		ComboDataDescription	nvarchar(100)	NOT NULL,
		ComboDataID				smallint		NOT NULL,
		StringID				int				NOT NULL,
		CONSTRAINT PK_ComboData PRIMARY KEY(ComboDataDescription, ComboDataID),
	)
ELSE
	print ('ComboData table already exists')

/* List of sympthos example: 
	ComboDataDescription		ComboDataID		StringID		String (from Strings table)
	Symptom						1				100				High temperature
	Symptom						2				101				Cough
	Symptom						3				102				Headache

	Severity
	ComboDataDescription		ComboDataID		StringID		String (from Strings table)
	Severity					1				200				Severe
	Severity					4				201				Medium
	Severity					3				202				Easy
*/

/************************************************************************************************************/
/* Data																										*/
/************************************************************************************************************/

IF OBJECT_ID (N'PatientsData', N'U') IS NULL 
	CREATE TABLE PatientsData (
		CheckDate					datetime		NOT NULL,
		PatientID					int				NOT NULL,
		Symptom						int				NOT NULL,
		SymptomValue				nvarchar(100)	NOT NULL,
		CONSTRAINT PK_PatientsData PRIMARY KEY(CheckDate desc,PatientID, Symptom),
		FOREIGN KEY (PatientID) REFERENCES Patients (PatientID)
	)
ELSE
	print ('PatientsData table already exists')



