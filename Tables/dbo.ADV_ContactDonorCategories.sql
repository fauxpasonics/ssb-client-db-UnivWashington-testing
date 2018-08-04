CREATE TABLE [dbo].[ADV_ContactDonorCategories]
(
[ContactID] [bigint] NOT NULL,
[CategoryID] [bigint] NOT NULL,
[Value] [varchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EXPORT_DATETIME] [datetime] NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
ALTER TABLE [dbo].[ADV_ContactDonorCategories] ADD CONSTRAINT [PK_ADV_ContactDonorCategories] PRIMARY KEY CLUSTERED  ([ContactID], [CategoryID])
GO
