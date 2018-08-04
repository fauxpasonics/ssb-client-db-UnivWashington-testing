CREATE TABLE [dbo].[DimPlanType]
(
[DimPlanTypeId] [int] NOT NULL IDENTITY(1, 1),
[ETL__SourceSystem] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL__CreatedBy] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__DimPlanTy__ETL____3F865F66] DEFAULT (suser_name()),
[ETL__CreatedDate] [datetime] NOT NULL CONSTRAINT [DF__DimPlanTy__ETL____407A839F] DEFAULT (getdate()),
[ETL__StartDate] [datetime] NOT NULL CONSTRAINT [DF__DimPlanTy__ETL____416EA7D8] DEFAULT (getdate()),
[ETL__EndDate] [datetime] NULL,
[PlanTypeCode] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PlanTypeName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PlanTypeDesc] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PlanTypeClass] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [dbo].[DimPlanType] ADD CONSTRAINT [PK_DimPlanType] PRIMARY KEY CLUSTERED  ([DimPlanTypeId])
GO
