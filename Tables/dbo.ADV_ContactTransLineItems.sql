CREATE TABLE [dbo].[ADV_ContactTransLineItems]
(
[PrimaryKey] [bigint] NOT NULL,
[TransID] [bigint] NULL,
[ProgramID] [bigint] NULL,
[MatchProgramID] [bigint] NULL,
[TransAmount] [decimal] (18, 2) NULL,
[MatchAmount] [decimal] (18, 2) NULL,
[MatchingGift] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Comments] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EXPORT_DATETIME] [datetime] NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
ALTER TABLE [dbo].[ADV_ContactTransLineItems] ADD CONSTRAINT [PK_ADV_ContactTransLineItems] PRIMARY KEY CLUSTERED  ([PrimaryKey])
GO
