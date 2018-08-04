CREATE TABLE [stg].[Adobe_List]
(
[ETL_ID] [int] NOT NULL IDENTITY(1, 1),
[ETL_CreatedDate] [datetime] NOT NULL CONSTRAINT [DF__Adobe_Lis__ETL_C__4F4333A3] DEFAULT (getdate()),
[ETL_FileName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PrimaryKey] [bigint] NOT NULL,
[ListID] [bigint] NOT NULL,
[CreationDate] [datetime] NOT NULL,
[Email] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[InternalName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Label] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [stg].[Adobe_List] ADD CONSTRAINT [PK__Adobe_Li__BC8954FF354CFAA2] PRIMARY KEY CLUSTERED  ([PrimaryKey], [CreationDate], [ListID])
GO
