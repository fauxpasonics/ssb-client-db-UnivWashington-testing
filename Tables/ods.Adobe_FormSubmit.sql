CREATE TABLE [ods].[Adobe_FormSubmit]
(
[ETL_ID] [int] NOT NULL IDENTITY(1, 1),
[ETL_CreatedDate] [datetime] NOT NULL CONSTRAINT [DF__Adobe_For__ETL_C__0A8E16A3] DEFAULT (getdate()),
[ETL_UpdatedDate] [datetime] NOT NULL CONSTRAINT [DF__Adobe_For__ETL_U__0B823ADC] DEFAULT (getdate()),
[ETL_IsDeleted] [bit] NOT NULL CONSTRAINT [DF__Adobe_For__ETL_I__0C765F15] DEFAULT ((0)),
[ETL_DeletedDate] [datetime] NULL,
[ETL_DeltaHashKey] [binary] (32) NULL,
[ETL_FileName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PrimaryKey] [bigint] NOT NULL,
[AccountPrimaryKey] [bigint] NOT NULL,
[PacId] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Email] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SubmitDate] [datetime] NULL,
[WebAppLabel] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[WebAppName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[URL] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SendSubmitstoSFDC] [bit] NULL
)
GO
ALTER TABLE [ods].[Adobe_FormSubmit] ADD CONSTRAINT [PK__Adobe_Fo__A2D9E5649FBDAE76] PRIMARY KEY CLUSTERED  ([PrimaryKey])
GO
