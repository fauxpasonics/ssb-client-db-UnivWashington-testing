CREATE TABLE [dbo].[ADV_DonorCategories]
(
[PrimaryKey] [bigint] NOT NULL,
[CategoryCode] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CategoryName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AffectsPriorityPoints] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EXPORT_DATETIME] [datetime] NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
ALTER TABLE [dbo].[ADV_DonorCategories] ADD CONSTRAINT [PK_ADV_DonorCategories] PRIMARY KEY CLUSTERED  ([PrimaryKey])
GO
