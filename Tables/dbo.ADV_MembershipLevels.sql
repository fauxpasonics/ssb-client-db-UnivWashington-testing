CREATE TABLE [dbo].[ADV_MembershipLevels]
(
[MembershipID] [bigint] NULL,
[LevelID] [bigint] NOT NULL,
[LevelName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MinAmount] [decimal] (18, 2) NULL,
[EXPORT_DATETIME] [datetime] NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
ALTER TABLE [dbo].[ADV_MembershipLevels] ADD CONSTRAINT [PK_ADV_MembershipLevels] PRIMARY KEY CLUSTERED  ([LevelID])
GO
