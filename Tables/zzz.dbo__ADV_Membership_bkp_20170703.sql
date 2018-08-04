CREATE TABLE [zzz].[dbo__ADV_Membership_bkp_20170703]
(
[MembID] [int] NOT NULL,
[MembershipName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[TransYear] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
ALTER TABLE [zzz].[dbo__ADV_Membership_bkp_20170703] ADD CONSTRAINT [PK_Memberships] PRIMARY KEY CLUSTERED  ([MembID])
GO
