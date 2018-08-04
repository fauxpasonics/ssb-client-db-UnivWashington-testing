CREATE TABLE [stg].[Adobe_TrackingLog]
(
[ETL_ID] [int] NOT NULL IDENTITY(1, 1),
[ETL_CreatedDate] [datetime] NOT NULL CONSTRAINT [DF__Adobe_Tra__ETL_C__4CB0DFBB] DEFAULT (getdate()),
[ETL_FileName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PrimaryKey] [bigint] NOT NULL,
[LogDate] [datetime] NULL,
[Email] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DeliveryFK] [bigint] NULL,
[AccountFK] [bigint] NULL,
[InternalName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[URLType] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[URLLabel] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SourceURL] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Browser] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
