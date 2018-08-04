CREATE TABLE [zzz].[dbo__ADV_MembershipLevels_bkp_20170703]
(
[MembID] [int] NOT NULL,
[LevelID] [int] NOT NULL,
[LevelName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MinAmount] [money] NULL,
[MaxAmount] [money] NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
ALTER TABLE [zzz].[dbo__ADV_MembershipLevels_bkp_20170703] ADD CONSTRAINT [PK_MembershipLevels] PRIMARY KEY CLUSTERED  ([LevelID])
GO
CREATE NONCLUSTERED INDEX [IX_MembershipLevels] ON [zzz].[dbo__ADV_MembershipLevels_bkp_20170703] ([MembID], [LevelID])
GO
