CREATE TABLE [zzz].[DimItem]
(
[DimItemId] [int] NOT NULL IDENTITY(1, 1),
[DimSeasonId] [int] NOT NULL,
[ItemCode] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ItemName] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ItemDesc] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ItemClass] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ItemStatus] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
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
[CreatedDate] [datetime] NOT NULL CONSTRAINT [DF__DimItem__Created__74444068] DEFAULT (getdate()),
[UpdatedDate] [datetime] NOT NULL CONSTRAINT [DF__DimItem__Updated__753864A1] DEFAULT (getdate()),
[IsDeleted] [bit] NOT NULL CONSTRAINT [DF__DimItem__IsDelet__762C88DA] DEFAULT ((0)),
[DeleteDate] [datetime] NULL,
[Config_IsFactSalesEligible] [bit] NULL,
[Config_IsClosed] [bit] NULL,
[DimSeasonHeaderId] [int] NULL
)
GO
ALTER TABLE [zzz].[DimItem] ADD CONSTRAINT [PK_DimItem] PRIMARY KEY CLUSTERED  ([DimItemId])
GO
CREATE NONCLUSTERED INDEX [IDX_Config_IsClosed] ON [zzz].[DimItem] ([Config_IsClosed])
GO
CREATE NONCLUSTERED INDEX [IDX_Config_IsFactSalesEligible] ON [zzz].[DimItem] ([Config_IsFactSalesEligible])
GO
CREATE NONCLUSTERED INDEX [IDX_DimSeasonId] ON [zzz].[DimItem] ([DimSeasonId])
GO
CREATE NONCLUSTERED INDEX [IDX_ItemCode] ON [zzz].[DimItem] ([ItemCode])
GO
CREATE UNIQUE NONCLUSTERED INDEX [IDX_LoadKey] ON [zzz].[DimItem] ([SourceSystem], [SSID_event_id])
GO
