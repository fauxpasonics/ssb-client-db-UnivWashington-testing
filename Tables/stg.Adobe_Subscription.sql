CREATE TABLE [stg].[Adobe_Subscription]
(
[ETL_ID] [int] NOT NULL IDENTITY(1, 1),
[ETL_CreatedDate] [datetime] NOT NULL CONSTRAINT [DF__Adobe_Sub__ETL_C__7568DC8B] DEFAULT (getdate()),
[ETL_FileName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PrimaryKey] [bigint] NOT NULL,
[Email] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CreationDate] [datetime] NOT NULL,
[ServiceID] [int] NOT NULL,
[ServiceInternalName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ServiceLabel] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [stg].[Adobe_Subscription] ADD CONSTRAINT [PK__Adobe_Su__33AFCC676006C72C] PRIMARY KEY CLUSTERED  ([PrimaryKey], [CreationDate], [ServiceID])
GO
