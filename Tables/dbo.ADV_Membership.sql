CREATE TABLE [dbo].[ADV_Membership]
(
[MembershipID] [bigint] NOT NULL,
[MembershipName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TransYear] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EXPORT_DATETIME] [datetime] NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
ALTER TABLE [dbo].[ADV_Membership] ADD CONSTRAINT [PK_ADV_Membership] PRIMARY KEY CLUSTERED  ([MembershipID])
GO
