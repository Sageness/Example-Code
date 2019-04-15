/*
	RefPhysician Temp Table Create Script
	 ___________________________________________________________________________________
	|Script Version		|Author			|Description									|
	|-------------------|---------------|-----------------------------------------------|
	|Version 1.0		|Sage Aucoin	|Script Creation								|
	|					|				|												|
	|					|				|												|
	|					|				|												|
	|___________________|_______________|_______________________________________________|
	
	Rules:
		1.) ReferringID should be filled with a unique ID that 
		2.) Signature should be FirstName MI LastName, Suffix. If no suffix is available,
			then it should just be FirstName MI LastName.

	Notes:
		1.) NPI should be a 10 digit number that can be verified on a number of different Websites.
		2.) NPI is unique per provider. Some practices have a Practice NPI. Make sure to map this accordingly.
*/


CREATE TABLE Import_RefPhysician(
	PK_RefPhysicianImportID INT IDENTITY(1,1),
	ReferringID NVARCHAR(50) UNIQUE NOT NULL,
	ExternalID1 NVARCHAR(50),
	ExternalID2 NVARCHAR(50),
	ExternalID3 NVARCHAR(50),
	NPI INT, 
	TaxId INT,
	Title NVARCHAR(10),
	Suffix NVARCHAR(10),
	Specialty NVARCHAR(100),
	FirstName NVARCHAR(50),
	LastName NVARCHAR(50),
	MiddleName NVARCHAR(50),
	Signature NVARCHAR(50),
	Address1 NVARCHAR(50),
	Address2 NVARCHAR(50),
	City NVARCHAR(50),
	State NVARCHAR(50),
	Zip NVARCHAR(50),
	Email1 NVARCHAR(50),
	Email2 NVARCHAR(50),
	OfficePhone NVARCHAR(50),
	HomePhone NVARCHAR(20),
	CellPhone NVARCHAR(20),
	FaxPhone NVARCHAR(20),
	PracticeExternalId NVARCHAR(50),
	PracticeName NVARCHAR(100),
	PracticeAddress1 NVARCHAR(50),
	PracticeAddress2 NVARCHAR(50),
	PracticeCity NVARCHAR(50),
	PracticeState NVARCHAR(50),
	PracticeZip NVARCHAR(50),
	PracticePhone NVARCHAR(50),
	PracticeNPI INT,
	IsEmailEnabled BIT NOT NULL,
	AcceptedPhysicianOrderTerms BIT DEFAULT 0 NOT NULL,
	IsActive BIT DEFAULT 1 NOT NULL,
)