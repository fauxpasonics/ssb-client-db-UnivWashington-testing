CREATE TABLE [zzz].[dbo__ADV_CorrespondenceStatus_bkp_20170703]
(
[Code] [char] (12) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Description] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Locked] [bit] NOT NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
ALTER TABLE [zzz].[dbo__ADV_CorrespondenceStatus_bkp_20170703] ADD CONSTRAINT [PK_CorrespondenceStatus] PRIMARY KEY CLUSTERED  ([Code])
GO
