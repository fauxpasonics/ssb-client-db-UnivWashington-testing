CREATE TABLE [dbo].[ADV_ContactAddresses]
(
[PrimaryKey] [bigint] NOT NULL,
[ContactID] [bigint] NULL,
[Code] [char] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AttnName] [varchar] (60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Company] [varchar] (60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Address1] [varchar] (60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Address2] [varchar] (60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Address3] [varchar] (60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[City] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[State] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Zip] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[County] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Country] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[StartDate] [datetime] NULL,
[EndDate] [datetime] NULL,
[Region] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PrimaryAddress] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TicketAddress] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EXPORT_DATETIME] [datetime] NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
ALTER TABLE [dbo].[ADV_ContactAddresses] ADD CONSTRAINT [PK_ADV_ContactAddresses] PRIMARY KEY CLUSTERED  ([PrimaryKey])
GO
