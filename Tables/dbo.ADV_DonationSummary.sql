CREATE TABLE [dbo].[ADV_DonationSummary]
(
[ContactID] [bigint] NOT NULL,
[TransYear] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ProgramID] [bigint] NOT NULL,
[CashPledges] [decimal] (18, 2) NULL,
[CashReceipts] [decimal] (18, 2) NULL,
[GIKPledges] [decimal] (18, 2) NULL,
[GIKReceipts] [decimal] (18, 2) NULL,
[MatchPledges] [decimal] (18, 2) NULL,
[MatchReceipts] [decimal] (18, 2) NULL,
[Credits] [decimal] (18, 2) NULL,
[EXPORT_DATETIME] [datetime] NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
ALTER TABLE [dbo].[ADV_DonationSummary] ADD CONSTRAINT [PK_ADV_DonationSummary] PRIMARY KEY CLUSTERED  ([ContactID], [TransYear], [ProgramID])
GO
