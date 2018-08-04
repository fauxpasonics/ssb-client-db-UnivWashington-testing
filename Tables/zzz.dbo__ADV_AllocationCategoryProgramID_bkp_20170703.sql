CREATE TABLE [zzz].[dbo__ADV_AllocationCategoryProgramID_bkp_20170703]
(
[CategoryID] [int] NOT NULL,
[ProgramID] [int] NOT NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
ALTER TABLE [zzz].[dbo__ADV_AllocationCategoryProgramID_bkp_20170703] ADD CONSTRAINT [PK__AllocationCatego__79A81403] PRIMARY KEY CLUSTERED  ([CategoryID], [ProgramID])
GO
