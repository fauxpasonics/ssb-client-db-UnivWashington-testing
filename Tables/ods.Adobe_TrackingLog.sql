CREATE TABLE [ods].[Adobe_TrackingLog]
(
[ETL_ID] [int] NOT NULL IDENTITY(1, 1),
[ETL_CreatedDate] [datetime] NOT NULL CONSTRAINT [DF__Adobe_Tra__ETL_C__48E04ED7] DEFAULT (getdate()),
[ETL_UpdatedDate] [datetime] NOT NULL CONSTRAINT [DF__Adobe_Tra__ETL_U__49D47310] DEFAULT (getdate()),
[ETL_IsDeleted] [bit] NOT NULL CONSTRAINT [DF__Adobe_Tra__ETL_I__4AC89749] DEFAULT ((0)),
[ETL_DeletedDate] [datetime] NULL,
[ETL_DeltaHashKey] [binary] (32) NULL,
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
ALTER TABLE [ods].[Adobe_TrackingLog] ADD CONSTRAINT [PK__Adobe_Tr__A2D9E564DFCF7D70] PRIMARY KEY CLUSTERED  ([PrimaryKey])
GO
