CREATE TABLE [ods].[Adobe_AccountMerges]
(
[ETL_ID] [int] NOT NULL IDENTITY(1, 1),
[ETL_CreatedDate] [datetime] NOT NULL CONSTRAINT [DF__Adobe_Acc__ETL_C__7D9C290A] DEFAULT (getdate()),
[ETL_IsProcessed] [bit] NOT NULL CONSTRAINT [DF__Adobe_Acc__ETL_I__7E904D43] DEFAULT ((0)),
[ETL_ProcessedDate] [datetime] NULL,
[ETL_FileName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MergeDate] [datetime] NOT NULL,
[MasterPatron] [bigint] NOT NULL,
[MergedPatron] [bigint] NOT NULL,
[MasterAdobeID] [bigint] NOT NULL,
[ChildAdobeID] [bigint] NOT NULL
)
GO
