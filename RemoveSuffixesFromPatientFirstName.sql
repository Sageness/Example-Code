/*									Patient Name Updater													*/
/*								By: Sage Aucoin (Jun 01, 2016)												*/
/*																											*/
/*					Purpose: Remove suffixes from Patient First Name in Patient Info						*/
/*																											*/
/*					Terms: LTRIM/RTRIM -- Removes whitespaces from beginning and end of result.				*/
/*																											*/
/*						   REPLACE -- (column, text, newText)												*/
/*																											*/
/*					Notes: Be weary of patients that have only the suffix for their first name.				*/
/*						   Check with the following SELECT statement before running UPDATE.					*/
/*																											*/
/*								SELECT * FROM PatientInfo													*/
/*								WHERE (																		*/
/*								   [Patient First] LIKE 'Mr.%'												*/
/*								OR [Patient First] LIKE 'Mr %'												*/
/*								OR [Patient First] LIKE 'Mrs.%'												*/
/*								OR [Patient First] LIKE 'Mrs %'												*/
/*								OR [Patient First] LIKE 'Ms.%'												*/
/*								OR [Patient First] LIKE 'Ms %'												*/
/*								OR [Patient First] LIKE 'Miss.%'											*/
/*								OR [Patient First] LIKE 'Miss %'											*/
/*								OR [Patient First] LIKE 'Dr.%'												*/
/*								OR [Patient First] LIKE 'Dr %')												*/
/*								AND LEN([Patient First]) < 5												*/



UPDATE PatientInfo
SET [Patient First] =	LTRIM(
							RTRIM(
								REPLACE(
									REPLACE(
										REPLACE(
											REPLACE(
												REPLACE([Patient First], 'Mr ', ''),
											'Mrs ', ''),
										'Ms ', ''),
									'Miss ', ''),
								'Dr ', '')
							)
						)
WHERE id <> 'ppcarefl-1-WHIDR.0001'			--This patient's first name is "DR." Don't remove. 
AND (
[Patient First] LIKE 'Mr.%'
OR [Patient First] LIKE 'Mr %'
OR [Patient First] LIKE 'Mrs.%'
OR [Patient First] LIKE 'Mrs %'
OR [Patient First] LIKE 'Ms.%'
OR [Patient First] LIKE 'Ms %'
OR [Patient First] LIKE 'Miss.%'
OR [Patient First] LIKE 'Miss %'
OR [Patient First] LIKE 'Dr.%'
OR [Patient First] LIKE 'Dr %') -- If any prefixes are missed, add them inside these parenthesis using the same format as the others. Don't forget the space after!

