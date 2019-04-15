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


CREATE TABLE Import_Users(
	PK_UserImportID INT IDENTITY(1,1),
	UserName NVARCHAR(15)
)