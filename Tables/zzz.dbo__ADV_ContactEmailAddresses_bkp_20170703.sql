CREATE TABLE [zzz].[dbo__ADV_ContactEmailAddresses_bkp_20170703]
(
[EmailAddressID] [int] NOT NULL,
[ContactID] [int] NOT NULL,
[Email] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Description] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PrimaryAddress] [bit] NOT NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
ALTER TABLE [zzz].[dbo__ADV_ContactEmailAddresses_bkp_20170703] ADD CONSTRAINT [PK_ContactEmailAddresses] PRIMARY KEY CLUSTERED  ([EmailAddressID])
GO
CREATE NONCLUSTERED INDEX [IX_ContactID] ON [zzz].[dbo__ADV_ContactEmailAddresses_bkp_20170703] ([ContactID])
GO
CREATE NONCLUSTERED INDEX [IX_ContactID_EmailAddressID] ON [zzz].[dbo__ADV_ContactEmailAddresses_bkp_20170703] ([ContactID], [EmailAddressID])
GO
CREATE NONCLUSTERED INDEX [IX_ContactID_i_Email_PrimaryAddress] ON [zzz].[dbo__ADV_ContactEmailAddresses_bkp_20170703] ([Email], [PrimaryAddress], [ContactID])
GO
