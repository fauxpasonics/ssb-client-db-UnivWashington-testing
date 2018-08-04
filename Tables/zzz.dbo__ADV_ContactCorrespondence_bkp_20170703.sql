CREATE TABLE [zzz].[dbo__ADV_ContactCorrespondence_bkp_20170703]
(
[PK] [int] NOT NULL,
[ContactID] [int] NULL,
[ContactedBy] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CorrDate] [datetime] NULL,
[Contact] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Type] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Subject] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Notes] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Status] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Private] [bit] NULL,
[SentToTixOffice] [bit] NULL,
[DateTimeSentToTixOffice] [datetime] NULL,
[ProposedDonation] [money] NULL,
[NegotiatedDonation] [money] NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
ALTER TABLE [zzz].[dbo__ADV_ContactCorrespondence_bkp_20170703] ADD CONSTRAINT [PK_ContactCorrespondence] PRIMARY KEY CLUSTERED  ([PK])
GO
CREATE NONCLUSTERED INDEX [IX_ContactedBy_Status] ON [zzz].[dbo__ADV_ContactCorrespondence_bkp_20170703] ([ContactedBy], [Status])
GO
CREATE NONCLUSTERED INDEX [IX_ContactIDCorrDate] ON [zzz].[dbo__ADV_ContactCorrespondence_bkp_20170703] ([ContactID], [CorrDate])
GO
CREATE NONCLUSTERED INDEX [IX_ContactedBy_Status_i_PK_ContactID_CorrDate_Type_Subject] ON [zzz].[dbo__ADV_ContactCorrespondence_bkp_20170703] ([PK], [ContactID], [CorrDate], [Type], [Subject], [ContactedBy], [Status])
GO
