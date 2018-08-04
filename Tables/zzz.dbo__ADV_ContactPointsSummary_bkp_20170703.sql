CREATE TABLE [zzz].[dbo__ADV_ContactPointsSummary_bkp_20170703]
(
[PK] [int] NOT NULL,
[ContactID] [int] NOT NULL,
[Description] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Points] [int] NOT NULL,
[Linked] [bit] NOT NULL,
[Value] [money] NOT NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
ALTER TABLE [zzz].[dbo__ADV_ContactPointsSummary_bkp_20170703] ADD CONSTRAINT [PK_ContactPointsSummary] PRIMARY KEY CLUSTERED  ([PK])
GO
CREATE NONCLUSTERED INDEX [IX_ContactPointsSummary] ON [zzz].[dbo__ADV_ContactPointsSummary_bkp_20170703] ([ContactID], [Points])
GO
