CREATE TABLE [zzz].[dbo__ADV_TransactionGroups_bkp_20170703]
(
[TransGroupID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[TransGroupName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
ALTER TABLE [zzz].[dbo__ADV_TransactionGroups_bkp_20170703] ADD CONSTRAINT [PK_TransactionGroups] PRIMARY KEY CLUSTERED  ([TransGroupID])
GO
