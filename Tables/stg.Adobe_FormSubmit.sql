CREATE TABLE [stg].[Adobe_FormSubmit]
(
[ETL_ID] [int] NOT NULL IDENTITY(1, 1),
[ETL_CreatedDate] [datetime] NOT NULL CONSTRAINT [DF__Adobe_For__ETL_C__0E5EA787] DEFAULT (getdate()),
[ETL_FileName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PrimaryKey] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[AccountPrimaryKey] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[PacId] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Email] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SubmitDate] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[WebAppLabel] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[WebAppName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[URL] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SendSubmitstoSFDC] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
