CREATE TABLE [dbo].[ADV_ContactPointsSummary]
(
[PrimaryKey] [bigint] NOT NULL,
[ContactID] [bigint] NULL,
[Description] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Points] [float] NULL,
[Linked] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EXPORT_DATETIME] [datetime] NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
ALTER TABLE [dbo].[ADV_ContactPointsSummary] ADD CONSTRAINT [PK_ADV_ContactPointsSummary] PRIMARY KEY CLUSTERED  ([PrimaryKey])
GO
