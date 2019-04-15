/*--------------------------------------------------------------------------------------*/
/*								Phone Parser 											*/
/*						 Prepared by: Sage Aucoin										*/	
/*				The purpose of this script is to address the data migration  			*/
/*				  issue involving the xyz company having a free text field		 		*/
/*				  for phone number data entry. 			 								*/
/*																						*/
/*								Example data: 					 						*/
/*		'phone: 123-345-1234&amp;workphone:124-142-3461 x 1412 							*/
/*		 cell: 4421921489 																*/
/*		 PATIENT SCHEDULED FOR MRI ON JUNE 27 Emergency: 123-154-1346'					*/
/*--------------------------------------------------------------------------------------*/

;
WITH CTE
AS (SELECT
	nid,
	a.workNumber,
	a.homeNumber,
	a.officeNumber,
	a.cellNumber,
	a.emergencyNumber,
	a.miscData,
	t.c.value('.', 'VARCHAR(2000)') Phone -- Replace this with phone column of source table
FROM (SELECT
	ROW_NUMBER() OVER (ORDER BY (SELECT
		1)
	) nid,
	workNumber,									/*		Replace these columns with their 	*/
	homeNumber,                                 /*		appropriate destinations in the 	*/   
	officeNumber,                               /*		table below							*/   
	cellNumber,                                 /*											*/   
	emergencyNumber,                            /*											*/   
	miscData,                                   /*											*/   
	x = CAST                                    /*		This CAST and set of REPLACEs 		*/   
	('<t>' +									/*		sets up the data in XML to be 		*/
		REPLACE                                 /*		parsed later.						*/
			(REPLACE                            /*											*/
				(REPLACE
					(REPLACE
						(REPLACE
							(REPLACE
								(phone, 'Work', '</t><t>work')				-- Replace this with phone column of source table
						, 'Office', '</t><t>Office')
					, 'Home', '</t><t>Home')
				, 'Cell', '</t><t>cell')
			, 'emergency', '</t><t>emergency')
		, 'misc', '</t><t>misc')
	+ '</t>' AS XML)
FROM Rlogic.MigratedUsers  -- Replace this with the source table is being parsed. I recommend importing data to a temp table and then running this on that temp table. 
) a
CROSS APPLY X.nodes('/t') t (c)
WHERE t.c.value('.', 'VARCHAR(2000)') LIKE '%[0-9][0-9][0-9]%'),
CTE2
AS (SELECT
	workNumber,
	MAX(CASE
		WHEN Phone LIKE '%work%' THEN Z													/*											 			*/
	END) OVER (PARTITION BY nid) nwork,                                                 /*														*/
	homeNumber,                                                                         /*														*/
	MAX(CASE                                                                            /*														*/
		WHEN Phone LIKE '%home%' THEN Z													/*														*/
	END) OVER (PARTITION BY nid) nhome,                                                 /*														*/
	officeNumber,                                                                       /*														*/
	MAX(CASE                                                                            /*														*/
		WHEN Phone LIKE '%office%' THEN Z												/*														*/
	END) OVER (PARTITION BY nid) noffice,												/*			Replace all instances of 'Phone' 			*/
	cellNumber,                                                                         /*			with phone column of table 					*/
	MAX(CASE                                                                            /*			requiring the parsing.						*/
		WHEN Phone LIKE '%cell%' THEN Z													/*														*/
	END) OVER (PARTITION BY nid) ncell,                                                 /*														*/
	emergencyNumber,                                                                    /*														*/
	MAX(CASE                                                                            /*														*/
		WHEN Phone LIKE '%emergency%' THEN Z											/*														*/
	END) OVER (PARTITION BY nid) nemergency,                                            /*														*/
	miscData,
	MAX(CASE
		WHEN Phone NOT LIKE '%emergency%' AND											--This condition saves other information that isn't part of the other phone categories.
			 Phone NOT LIKE '%cell%' AND
			 Phone NOT LIKE '%office%' AND
			 Phone NOT LIKE '%home%' AND
			 Phone NOT LIKE '%work%' THEN Z												-- Replace this with phone column of source table
	END) OVER (PARTITION BY nid) nMisc
FROM CTE t
CROSS APPLY (SELECT
	REVERSE(SUBSTRING(Phone, PATINDEX('%[0-9][0-9][0-9]%', Phone), 20)) x) y			-- Replace this with phone column of source table
CROSS APPLY (SELECT
	STUFF(STUFF(REPLACE(REPLACE(REPLACE(REVERSE(
	SUBSTRING(X, PATINDEX('%[0-9][0-9][0-9]%', X), 20)), ')', ''), '\', ''),
	'-', ''), 7, 0, '-'), 4, 0, '-') z) v)

--Finally, update the empty columns of the destination table
UPDATE CTE2
SET	workNumber = nwork,
	homeNumber = nhome,
	officeNumber = noffice,
	emergencyNumber = nemergency,
	cellNumber = ncell,
	miscData = nMisc