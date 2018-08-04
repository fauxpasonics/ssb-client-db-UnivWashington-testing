CREATE TABLE [zzz].[dbo__ADV_DonationSummary_bkp_20170703]
(
[ContactID] [int] NOT NULL,
[TransYear] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ProgramID] [int] NOT NULL,
[CashPledges] [money] NOT NULL,
[CashReceipts] [money] NOT NULL,
[GIKPledges] [money] NOT NULL,
[GIKReceipts] [money] NOT NULL,
[MatchPledges] [money] NOT NULL,
[MatchReceipts] [money] NOT NULL,
[Credits] [money] NOT NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
ALTER TABLE [zzz].[dbo__ADV_DonationSummary_bkp_20170703] ADD CONSTRAINT [PK_DonorStatistics] PRIMARY KEY CLUSTERED  ([ContactID], [TransYear], [ProgramID])
GO
CREATE NONCLUSTERED INDEX [IX_TransYear_i_ContactID_ProgramID] ON [zzz].[dbo__ADV_DonationSummary_bkp_20170703] ([ContactID], [ProgramID], [TransYear])
GO
CREATE NONCLUSTERED INDEX [IX_ TransYear_ProgramID_i_ContactID] ON [zzz].[dbo__ADV_DonationSummary_bkp_20170703] ([ContactID], [TransYear], [ProgramID])
GO
