EXEC sp_msforeachdb '
		USE ?
        IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
                    WHERE TABLE_NAME=''patientinfo'')
        BEGIN
            IF EXISTS 
				(SELECT *
			     FROM sys.COLUMNS c
				 WHERE OBJECT_NAME(object_id) = ''patientinfo''
			     AND Name = ''isVIP''
			    )
			BEGIN
				PRINT ''Found isVIP in ?, moving on.
				''
				--do nothing
			END	
			ELSE
			BEGIN
				PRINT ''No isVIP Found in ?, adding columns.
				''
				ALTER TABLE PatientInfo
				Add isVIP BIT NOT NULL DEFAULT 0,
					isNotifyAdminOnAccess BIT NOT NULL DEFAULT 0	
			END
        END
		ELSE
			PRINT ''No PatientInfo found in ?
			''
'


