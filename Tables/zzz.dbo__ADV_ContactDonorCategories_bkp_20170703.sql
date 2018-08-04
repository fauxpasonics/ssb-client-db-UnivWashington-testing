CREATE TABLE [zzz].[dbo__ADV_ContactDonorCategories_bkp_20170703]
(
[ContactID] [int] NOT NULL,
[CategoryID] [int] NOT NULL,
[Value] [varchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
ALTER TABLE [zzz].[dbo__ADV_ContactDonorCategories_bkp_20170703] ADD CONSTRAINT [PK_ContactDonorCategory] PRIMARY KEY CLUSTERED  ([ContactID], [CategoryID])
GO
CREATE NONCLUSTERED INDEX [IX_CategoryID] ON [zzz].[dbo__ADV_ContactDonorCategories_bkp_20170703] ([CategoryID])
GO
CREATE NONCLUSTERED INDEX [IX_CategoryID_i_ContactID_Value] ON [zzz].[dbo__ADV_ContactDonorCategories_bkp_20170703] ([ContactID], [Value], [CategoryID])
GO
