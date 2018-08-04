CREATE TABLE [zzz].[dbo__ADV_ContactTransLineItems_bkp_20170703]
(
[PK] [int] NOT NULL,
[TransID] [int] NULL,
[ProgramID] [int] NULL,
[MatchProgramID] [int] NULL,
[TransAmount] [money] NOT NULL,
[MatchAmount] [money] NOT NULL,
[MatchingGift] [bit] NOT NULL,
[Renew] [bit] NOT NULL,
[Renewed] [bit] NOT NULL,
[Comments] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
ALTER TABLE [zzz].[dbo__ADV_ContactTransLineItems_bkp_20170703] ADD CONSTRAINT [PK_ContactTransLineItems] PRIMARY KEY CLUSTERED  ([PK])
GO
CREATE NONCLUSTERED INDEX [IX_ProgramID] ON [zzz].[dbo__ADV_ContactTransLineItems_bkp_20170703] ([ProgramID], [TransID], [TransAmount])
GO
CREATE NONCLUSTERED INDEX [IX_TransID] ON [zzz].[dbo__ADV_ContactTransLineItems_bkp_20170703] ([TransID])
GO
CREATE NONCLUSTERED INDEX [IX_TransAmount_i_TransID_ProgramID] ON [zzz].[dbo__ADV_ContactTransLineItems_bkp_20170703] ([TransID], [ProgramID], [TransAmount])
GO
CREATE NONCLUSTERED INDEX [IX_ProgramID_i_TransID_TransAmount_MatchAmount] ON [zzz].[dbo__ADV_ContactTransLineItems_bkp_20170703] ([TransID], [TransAmount], [MatchAmount], [ProgramID])
GO
