CREATE TABLE [stg].[Adobe_Delivery]
(
[ETL_ID] [int] NOT NULL IDENTITY(1, 1),
[ETL_CreatedDate] [datetime] NOT NULL CONSTRAINT [DF__Adobe_Del__ETL_C__413F2D0F] DEFAULT (getdate()),
[ETL_FileName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PrimaryKey] [bigint] NOT NULL,
[ContactDate] [datetime] NULL,
[InternalName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Label] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MessagestoSend] [int] NULL,
[Processed] [int] NULL,
[Success] [int] NULL,
[Errors] [int] NULL,
[RecipientsWhoHaveOpened] [int] NULL,
[TotalCountofOpens] [int] NULL,
[PersonsWhoHaveClicked] [int] NULL,
[TotalNumberofClicks] [int] NULL,
[NumberofDistinctClicks] [int] NULL,
[FolderId] [bigint] NULL,
[FolderLabel] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DeliveryCode] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AssociatedEvents] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
