/*
	PatientInfo Temp Table Create Script
	 ___________________________________________________________________________________
	|Script Version		|Author			|Description									|
	|-------------------|---------------|-----------------------------------------------|
	|Version 1.0		|Sage Aucoin	|Script Creation								|
	|					|				|												|
	|					|				|												|
	|					|				|												|
	|___________________|_______________|_______________________________________________|
	
	Rules:
		1.) Race, Ethnicity, Language, and Marital Status should be the string value, not an 'ID'. 
		2.) PatientSex should be written as 'M' for Male, 'F' for Female, and 'U' for Unknown.
		3.) PatientMRN should be considered Primary/First ID. ExternalID 1-3 should be used for 
			all other IDs that the client wants/needs stored.

	Notes:
		1.) MaritalStatus is tied to the value of AccountEnums Where EnumType like '%MaritalStatus%'
		2.) Languages is tied to Global.dbo.Languages
		3.) Ethnicity is ties to Global.dbo.Ethnicity
		4.) Race is tied to dbo.PatientRaces via the AutoCount column of patientInfo and the RaceID
			found in Global.dbo.Race
*/


CREATE TABLE Import_PatientInfo(
	PK_PatientImportID INT IDENTITY(1,1),
	PatientMRN NVARCHAR(50) NOT NULL,
	ExternalID1 NVARCHAR(50),
	ExternalID2 NVARCHAR(50),
	ExternalID3 NVARCHAR(50),
	Title NVARCHAR(10),
	PatientFirstName NVARCHAR(50) NOT NULL,
	PatientLastName NVARCHAR(50) NOT NULL,
	PatientMiddleName NVARCHAR(50),
	PatientDateOfBirth NVARCHAR(50),
	PatientSex NVARCHAR(10),
	PatientSocialSecurityNumber NVARCHAR(50),
	PatientAddress1 NVARCHAR(50),
	PatientAddress2 NVARCHAR(50),
	PatientCity NVARCHAR(50),
	PatientState NVARCHAR(50),
	PatientZip NVARCHAR(50),
	PatientEmail1 NVARCHAR(50),
	PatientEmail2 NVARCHAR(50),
	PatientHomePhone NVARCHAR(20),
	PatientWorkPhone NVARCHAR(20),
	PatientCellPhone NVARCHAR(20),
	PatientFaxPhone NVARCHAR(20),
	MaritalStatus NVARCHAR(50),
	Ethnicity NVARCHAR(50),
	Race NVARCHAR(50),
	Language NVARCHAR(50),
	isActive BIT DEFAULT 1 NOT NULL,
	isDeceased BIT DEFAULT 0 NOT NULL,
	RequiresTranslator BIT DEFAULT 0 NOT NULL,
	IsSelfPay BIT DEFAULT 0 NOT NULL,
	CreatedDateTime DATETIME DEFAULT GETDATE() NOT NULL,
	LastModifiedDateTime DATETIME DEFAULT GETDATE() NOT NULL,
	IsFamilyHistoryUnknown BIT DEFAULT 0 NOT NULL
)