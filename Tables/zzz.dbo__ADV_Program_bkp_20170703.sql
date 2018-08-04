CREATE TABLE [zzz].[dbo__ADV_Program_bkp_20170703]
(
[ProgramID] [int] NOT NULL,
[ProgramCode] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ProgramName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ProgramGroup] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PriorityPercent] [money] NULL,
[SpecialEvent] [bit] NOT NULL,
[Inactive] [bit] NOT NULL,
[GLAccount] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MoneyPoints] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LifetimeGiving] [bit] NOT NULL,
[DonationValue] [money] NULL,
[Percentage] [bit] NOT NULL,
[AvailableOnline] [bit] NOT NULL,
[OnlineDescription] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BalanceOnline] [bit] NOT NULL,
[CapDriveYear] [bit] NOT NULL,
[PayInFullRequired] [bit] NOT NULL,
[AllowPaySchedules] [bit] NOT NULL,
[DeadlineDate] [datetime] NULL,
[AllowOnlinePayments] [bit] NOT NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
ALTER TABLE [zzz].[dbo__ADV_Program_bkp_20170703] ADD CONSTRAINT [PK_Program] PRIMARY KEY CLUSTERED  ([ProgramID])
GO
