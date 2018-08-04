CREATE TABLE [zzz].[dbo__ADV_DonorCategories_bkp_20170703]
(
[PK] [int] NOT NULL,
[CategoryCode] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CategoryName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ValueType] [varchar] (8) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AffectsPriorityPoints] [bit] NOT NULL,
[Locked] [bit] NOT NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
ALTER TABLE [zzz].[dbo__ADV_DonorCategories_bkp_20170703] ADD CONSTRAINT [PK_DonorCategories] PRIMARY KEY CLUSTERED  ([PK])
GO
