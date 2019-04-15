--Update Addresses using Master List
UPDATE MergedList
SET MergedList.Address = m.Address,
	MergedList.City = m.City,
	MergedList.State = m.State,
	Mergedlist.[Zip Code] = m.ZipCode
FROM MergedList ml
INNER JOIN Master2014 m ON m.HIC = ml.HIC

-- Add TIN# to Merged List
UPDATE MergedList
SET MergedList.TIN = th.TIN
FROM MergedList ml
INNER JOIN TINHelper th ON th.HIC = ml.HIC

-- Patients that are newly assigned based on HIC
SELECT * FROM [Quarter2_2014_Beneficiary_Assignments] 
WHERE NOT EXISTS 
	(SELECT *
	FROM [Quarter1_2014_Beneficiary_Assignments]
	WHERE [Quarter2_2014_Beneficiary_Assignments].HIC = [Quarter1_2014_Beneficiary_Assignments].HIC)

-- Patients that are no longer assigned based on HIC
SELECT * FROM [Quarter1_2014_Beneficiary_Assignments]
WHERE NOT EXISTS 
	(SELECT *
	FROM [Quarter2_2014_Beneficiary_Assignments]
	WHERE [Quarter1_2014_Beneficiary_Assignments].HIC = [Quarter2_2014_Beneficiary_Assignments].HIC)

-- Update Patient assignments in MergedList based on Quarter
UPDATE MergedList
SET Q1_2015_Assign = 1
FROM MergedList ml
INNER JOIN Quarter1_2015_Beneficiary_Assignments qba ON qba.HIC = ml.HIC

-- Clear NULLs
UPDATE MergedList
SET Q1_2015_Assign = 0
WHERE Q1_2015_Assign IS NULL

-- Get Dropped patients from a specific quarter
SELECT * FROM MergedList ml
WHERE ml.Q4_2014_Assign = 1
AND	  ml.Q1_2015_Assign = 0 

-- Get added patients from a specific quarter
SELECT * FROM MergedList ml
WHERE ml.Q4_2014_Assign = 0
AND	  ml.Q1_2015_Assign = 1 




-- Update MergedList with new Patients. Remember to add column for QAssn column
INSERT INTO MergedList (HIC, 
						TIN, 
						NPI,
						FirstName, 
						LastName, 
						Address, 
						City, 
						State, 
						[Zip Code], 
						Sex, 
						DOB, 
						DeceasedBeneficiary, 
						AssignmentStepFlag, 
						Q1_2014_Assign, 
						Q2_2014_Assign, 
						Q3_2014_Assign, 
						Q4_2014_Assign, 
						Q1_2015_Assign)
			SELECT  qba.HIC, 
					qba.ACOParticipantTIN, 
					qba.IndividualNPI,
					qba.FirstName, 
					qba.LastName, 
					NULL,
					NULL,
					NULL,
					NULL,
					qba.Sex, 
					qba.DOB, 
					qba.DeceasedBeneficiaryFlag, 
					NULL,
					0,
					0,
					0,
					0,
					1
			FROM Quarter1_2015_Beneficiary_Assignments qba 
			WHERE NOT EXISTS 
				(SELECT *
				FROM MergedList
				WHERE qba.HIC = MergedList.HIC)





-- Insert into PatientInfo where patients do not yet exist. 
INSERT INTO PatientInfo (id, 
						 Req, 
						 [MR Num], 
						 [Patient Last], 
						 [Patient First], 
						 [Pt DOB], 
						 Sex,
						 Address, 
						 City, 
						 State, 
						 Zipcode, 
						 ExternalID, 
						 ExternalID2,
						 ExternalID3, 
						 isDeceased)
SELECT 	NULL,
		NULL,
		NULL,
		puh.LastName,
		puh.FirstName,
		puh.DOB,
		puh.Sex,
		puh.Address,
		puh.City,
		puh.State,
		puh.ZipCode,
		puh.HIC,
		'T: '  + puh.TIN,
		'N: ' + puh.NPI,
		puh.DeceasedBeneficiary
FROM PatientInfo_Update_Helper puh
WHERE NOT EXISTS(SELECT *
				FROM PatientInfo_Update_Helper
				JOIN PatientInfo pi ON pi.ExternalID = puh.HIC
				WHERE PatientInfo_Update_Helper.HIC = pi.ExternalID)


--Incrementor for id, req, and MR NUM
DECLARE @i INT = 16533
WHILE (@i < 17923)
BEGIN
	UPDATE PatientInfo
	SET id = AutoCount + 10000,
		Req = AutoCount + 10000,
		[MR Num] = AutoCount + 10000
	WHERE AutoCount = @i
	SET @i = @i + 1
END;



--Set inactive patients for patientinfo
UPDATE PatientInfo
	SET isActive = 0
FROM PatientInfo pi
JOIN PatientInfo_Update_Helper piuh ON pi.ExternalID = piuh.HIC
WHERE piuh.Q1_2015_Assign = 0