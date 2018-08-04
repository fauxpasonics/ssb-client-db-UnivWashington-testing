CREATE TABLE [dbo].[ADV_Program]
(
[ProgramID] [bigint] NOT NULL,
[ProgramCode] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ProgramName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ProgramGroup] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PriorityPercent] [decimal] (18, 2) NULL,
[SpecialEvent] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Inactive] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LifetimeGiving] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DonationValue] [decimal] (18, 2) NULL,
[Percentage] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CapDriveYear] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EXPORT_DATETIME] [datetime] NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
ALTER TABLE [dbo].[ADV_Program] ADD CONSTRAINT [PK_ADV_Program] PRIMARY KEY CLUSTERED  ([ProgramID])
GO
