/*			Patient Multiple Identifiers Account Initialization			 */
/*			Prepared By: Sage Aucoin									 */
/*			Create Date: 07 July, 2016									 */
/*																		 */
/*			Purpose: Prepare an account database for the new		 	 */
/*					 Patient Multiple Identifier Feature.				 */
/*					 TFS #2097 for more info on feature.				 */
																		 
SET ANSI_NULLS ON														 
GO																		 
																		 
SET QUOTED_IDENTIFIER ON												 
GO

SET ANSI_PADDING ON
GO

/********************************************/
/********************************************/
/*			Drop existing Table				*/
/********************************************/
/********************************************/
DROP TABLE [dbo].[PatientMultipleIdentifiers]
GO

/************************************************************/
/************************************************************/
/*			Add AccountEnums Data for Legacy Source			*/
/************************************************************/
/************************************************************/
INSERT INTO AccountEnums (Name, Value, EnumType, IsVisible, UserCanEdit, UserCanDelete, CreateUser, CreateDate)
VALUES('Legacy External ID', 'Legacy External ID', 'ExtIdentifierSource', 1, 0, 0, 'Legacy Import', GETDATE())
GO

/************************************************************************/
/************************************************************************/
/*			Create New Table With New Columns and Constraints			*/
/************************************************************************/
/************************************************************************/
CREATE TABLE [dbo].[PatientMultipleIdentifiers](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[PatientID] [numeric](18, 0) NULL,
	[Identifier] [varchar](200) NOT NULL,
	[Source] [varchar](1000) NOT NULL,
	[CreateDate] [datetime] NOT NULL DEFAULT (getdate()),
	[CreateUser] [varchar](100) NOT NULL,
	[IsActive] [bit] NOT NULL DEFAULT ((1)),
	[IsDeleted] [bit] NOT NULL DEFAULT ((0)),
	[ModifiedDate] [datetime] NULL,
	[ModifiedUser] [varchar](100) NULL,
	[Sequence] [int] NULL,
	[ExtIdentifierSource] [varchar](1500) NULL,
 CONSTRAINT [PK_PatientMultipleIdentifiers] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[PatientMultipleIdentifiers]  WITH CHECK ADD  CONSTRAINT [FK_PatientMultipleIdentifiers_PatientInfo] FOREIGN KEY([PatientID])
REFERENCES [dbo].[PatientInfo] ([AutoCount])
GO

ALTER TABLE [dbo].[PatientMultipleIdentifiers] CHECK CONSTRAINT [FK_PatientMultipleIdentifiers_PatientInfo]
GO

/****************************************************************/
/****************************************************************/
/*			Update Potential External ID Errors where			*/
/*			externalId is null but externalID2 is not			*/
/****************************************************************/
/****************************************************************/
UPDATE PatientInfo
SET ExternalID = ExternalID2,
	ExternalID2 = NULL
WHERE ExternalID IS NULL AND ExternalID2 IS NOT NULL
GO

UPDATE PatientInfo
SET ExternalID2 = ExternalID3,
	ExternalID3 = NULL
WHERE ExternalID2 IS NULL AND ExternalID3 IS NOT NULL
GO

/************************************************************************/
/************************************************************************/
/*			Add data from PatientInfo using ExternalID 1,2,3			*/
/************************************************************************/
/************************************************************************/
INSERT INTO PatientMultipleIdentifiers (PatientID, Identifier, Source, CreateDate, CreateUser, IsActive, IsDeleted, Sequence, ExtIdentifierSource)
SELECT pi.AutoCount, pi.ExternalID, 'demoradiology', GETDATE(), 'Legacy Import', 1, 0, 1, 'Legacy External ID' FROM PatientInfo pi WHERE pi.ExternalID IS NOT NULL
GO

INSERT INTO PatientMultipleIdentifiers (PatientID, Identifier, Source, CreateDate, CreateUser, IsActive, IsDeleted, Sequence, ExtIdentifierSource)
SELECT pi.AutoCount, pi.ExternalID2, 'demoradiology', GETDATE(), 'Legacy Import', 1, 0, 2, 'Legacy External ID' FROM PatientInfo pi WHERE pi.ExternalID2 IS NOT NULL
GO

INSERT INTO PatientMultipleIdentifiers (PatientID, Identifier, Source, CreateDate, CreateUser, IsActive, IsDeleted, Sequence, ExtIdentifierSource)
SELECT pi.AutoCount, pi.ExternalID3, 'demoradiology', GETDATE(), 'Legacy Import', 1, 0, 3, 'Legacy External ID' FROM PatientInfo pi WHERE pi.ExternalID3 IS NOT NULL
GO