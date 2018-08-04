CREATE TABLE [dbo].[ADV_ContactCorrespondence]
(
[PrimaryKey] [bigint] NOT NULL,
[ContactID] [bigint] NULL,
[ContactedBy] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CorrDate] [datetime] NULL,
[Contact] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Type] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Subject] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Notes] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Status] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Private] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ProposedDonation] [decimal] (18, 2) NULL,
[NegotiatedDonation] [decimal] (18, 2) NULL,
[EXPORT_DATETIME] [datetime] NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
ALTER TABLE [dbo].[ADV_ContactCorrespondence] ADD CONSTRAINT [PK_ADV_ContactCorrespondence] PRIMARY KEY CLUSTERED  ([PrimaryKey])
GO
