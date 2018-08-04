CREATE TABLE [dbo].[ADV_TransactionGroups]
(
[TransGroupID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[TransGroupName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EXPORT_DATETIME] [datetime] NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
ALTER TABLE [dbo].[ADV_TransactionGroups] ADD CONSTRAINT [PK_ADV_TransactionGroups] PRIMARY KEY CLUSTERED  ([TransGroupID])
GO
