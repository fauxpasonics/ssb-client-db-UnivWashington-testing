CREATE TABLE [dbo].[ADV_ContactMembershipLevels]
(
[ContactID] [bigint] NOT NULL,
[MembID] [bigint] NOT NULL,
[OverrideLevel] [int] NULL,
[PledgeLevel] [int] NULL,
[ReceiptLevel] [int] NULL,
[EXPORT_DATETIME] [datetime] NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
ALTER TABLE [dbo].[ADV_ContactMembershipLevels] ADD CONSTRAINT [PK_ADV_ContactMembershipLevels] PRIMARY KEY CLUSTERED  ([ContactID], [MembID])
GO
