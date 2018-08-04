CREATE TABLE [dbo].[ADV_ContactEmailAddresses]
(
[EmailAddressID] [bigint] NOT NULL,
[ContactID] [bigint] NULL,
[Email] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Description] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PrimaryAddress] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EXPORT_DATETIME] [datetime] NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
ALTER TABLE [dbo].[ADV_ContactEmailAddresses] ADD CONSTRAINT [PK_ADV_ContactEmailAddresses] PRIMARY KEY CLUSTERED  ([EmailAddressID])
GO
