CREATE TABLE [dbo].[ADV_AllocationCategoryProgramID]
(
[CategoryID] [bigint] NOT NULL,
[ProgramID] [bigint] NOT NULL,
[EXPORT_DATETIME] [datetime] NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
ALTER TABLE [dbo].[ADV_AllocationCategoryProgramID] ADD CONSTRAINT [PK_ADV_AllocationCategoryProgramID] PRIMARY KEY CLUSTERED  ([CategoryID], [ProgramID])
GO
