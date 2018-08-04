CREATE TABLE [zzz].[DimEvent]
(
[DimEventId] [int] NOT NULL IDENTITY(1, 1),
[DimArenaId] [int] NOT NULL,
[DimSeasonId] [int] NOT NULL,
[DimEventHeaderId] [int] NOT NULL,
[EventCode] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EventName] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EventDesc] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EventClass] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EventDateTime] [datetime] NULL,
[EventDate] [date] NULL,
[EventTime] [time] NULL,
[EventStatus] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Capacity] [int] NULL,
[Attendance] [int] NULL,
[ScanEventId] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ManifestId] [int] NULL,
[SSCreatedBy] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SSUpdatedBy] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SSCreatedDate] [datetime] NULL,
[SSUpdatedDate] [datetime] NULL,
[SSID] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SSID_event_id] [int] NULL,
[SourceSystem] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DeltaHashKey] [binary] (32) NULL,
[CreatedBy] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UpdatedBy] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CreatedDate] [datetime] NOT NULL CONSTRAINT [DF__DimEvent__Create__66EA454A] DEFAULT (getdate()),
[UpdatedDate] [datetime] NOT NULL CONSTRAINT [DF__DimEvent__Update__67DE6983] DEFAULT (getdate()),
[IsDeleted] [bit] NOT NULL CONSTRAINT [DF__DimEvent__IsDele__68D28DBC] DEFAULT ((0)),
[DeleteDate] [datetime] NULL,
[IsClosed] [bit] NOT NULL CONSTRAINT [DF__DimEvent__IsClos__69C6B1F5] DEFAULT ((0)),
[IsInventoryEligible] [bit] NULL,
[MajorCategoryTM] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MinorCategoryTM] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Config_IsRealTimeAttendanceEnabled] [bit] NULL,
[EventOpenTime] [datetime] NULL,
[EventFinishTime] [datetime] NULL
)
GO
ALTER TABLE [zzz].[DimEvent] ADD CONSTRAINT [PK_DimEvent] PRIMARY KEY CLUSTERED  ([DimEventId])
GO
CREATE NONCLUSTERED INDEX [IDX_Config_IsRealTimeAttendanceEnabled] ON [zzz].[DimEvent] ([Config_IsRealTimeAttendanceEnabled])
GO
CREATE NONCLUSTERED INDEX [IDX_DimSeasonId] ON [zzz].[DimEvent] ([DimSeasonId])
GO
CREATE NONCLUSTERED INDEX [IDX_EventClass] ON [zzz].[DimEvent] ([EventClass])
GO
CREATE NONCLUSTERED INDEX [IDX_EventCode] ON [zzz].[DimEvent] ([EventCode])
GO
CREATE NONCLUSTERED INDEX [IDX_EventDate] ON [zzz].[DimEvent] ([EventDate])
GO
CREATE NONCLUSTERED INDEX [IDX_EventDateTime] ON [zzz].[DimEvent] ([EventDateTime])
GO
CREATE NONCLUSTERED INDEX [IDX_ManifestId] ON [zzz].[DimEvent] ([ManifestId])
GO
CREATE UNIQUE NONCLUSTERED INDEX [IDX_LoadKey] ON [zzz].[DimEvent] ([SourceSystem], [SSID_event_id])
GO
