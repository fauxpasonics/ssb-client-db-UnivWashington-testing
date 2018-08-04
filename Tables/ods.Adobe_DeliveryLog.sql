CREATE TABLE [ods].[Adobe_DeliveryLog]
(
[ETL_ID] [int] NOT NULL IDENTITY(1, 1),
[ETL_CreatedDate] [datetime] NOT NULL CONSTRAINT [DF__Adobe_Del__ETL_C__109BF5B4] DEFAULT (getdate()),
[ETL_UpdatedDate] [datetime] NOT NULL CONSTRAINT [DF__Adobe_Del__ETL_U__119019ED] DEFAULT (getdate()),
[ETL_IsDeleted] [bit] NOT NULL CONSTRAINT [DF__Adobe_Del__ETL_I__12843E26] DEFAULT ((0)),
[ETL_DeletedDate] [datetime] NULL,
[ETL_DeltaHashKey] [binary] (32) NULL,
[ETL_FileName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PrimaryKey] [bigint] NOT NULL,
[EventDate] [datetime] NULL,
[InternalName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Address] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Status] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FailureType] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Reason] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DeliveryFK] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AccountFK] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [ods].[Adobe_DeliveryLog] ADD CONSTRAINT [PK__Adobe_De__A2D9E564FBE63AD4] PRIMARY KEY CLUSTERED  ([PrimaryKey])
GO
