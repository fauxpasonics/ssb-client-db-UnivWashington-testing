CREATE TABLE [dbo].[ADV_CorrespondenceStatus]
(
[Status] [char] (12) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Description] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EXPORT_DATETIME] [datetime] NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
ALTER TABLE [dbo].[ADV_CorrespondenceStatus] ADD CONSTRAINT [PK_ADV_CorrespondenceStatus] PRIMARY KEY CLUSTERED  ([Status])
GO
