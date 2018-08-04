CREATE TABLE [zzz].[dbo__ADV_Status_bkp_20170703]
(
[code] [char] (12) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[description] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DonorStatement] [bit] NOT NULL,
[Locked] [bit] NOT NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
ALTER TABLE [zzz].[dbo__ADV_Status_bkp_20170703] ADD CONSTRAINT [PK_Status] PRIMARY KEY CLUSTERED  ([code])
GO
