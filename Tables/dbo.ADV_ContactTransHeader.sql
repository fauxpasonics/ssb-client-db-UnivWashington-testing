CREATE TABLE [dbo].[ADV_ContactTransHeader]
(
[TransID] [bigint] NOT NULL,
[ContactID] [bigint] NULL,
[TransYear] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TransDate] [datetime] NULL,
[TransGroup] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TransType] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MatchingAcct] [int] NULL,
[MatchingTransID] [bigint] NULL,
[PaymentType] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CheckNo] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EnterDateTime] [datetime] NULL,
[EnterByUser] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BatchRefNo] [int] NULL,
[EXPORT_DATETIME] [datetime] NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
ALTER TABLE [dbo].[ADV_ContactTransHeader] ADD CONSTRAINT [PK_ADV_ContactTransHeader] PRIMARY KEY CLUSTERED  ([TransID])
GO
