CREATE TABLE [zzz].[dbo__ADV_ContactMembershipLevels_bkp_20170703]
(
[ContactID] [int] NOT NULL,
[MembID] [int] NOT NULL,
[OverrideLevel] [int] NULL,
[PledgeLevel] [int] NULL,
[ReceiptLevel] [int] NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
ALTER TABLE [zzz].[dbo__ADV_ContactMembershipLevels_bkp_20170703] ADD CONSTRAINT [PK_ContactMembershipLevels] PRIMARY KEY CLUSTERED  ([ContactID], [MembID])
GO
