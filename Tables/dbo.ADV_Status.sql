CREATE TABLE [dbo].[ADV_Status]
(
[Code] [char] (12) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Description] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DonorStatement] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EXPORT_DATETIME] [datetime] NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
ALTER TABLE [dbo].[ADV_Status] ADD CONSTRAINT [PK_ADV_Status] PRIMARY KEY CLUSTERED  ([Code])
GO
