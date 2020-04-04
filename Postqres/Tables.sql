CREATE TABLE dbo.MedicalCenters (
		MedicalCenterID				SERIAL,
		MedicalCenterDescription	varchar(100)	NOT NULL,
		Street						varchar(100)	NOT NULL,
		StreetNumber				varchar(10)		NOT NULL,
		City						varchar(100) 	NOT NULL,
		InsertDate					TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
		UpdateDate					TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
		Active						tinyint			NOT NULL,
		GeoLocation					nvarchar		NOT NULL	DEFAULT '',
		PRIMARY KEY (MedicalCenterID)
	)
