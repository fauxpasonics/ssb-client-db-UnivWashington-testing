CREATE TABLE [zzz].[dbo__ADV_ContactTransHeader_bkp_20170703]
(
[TransID] [int] NOT NULL,
[ContactID] [int] NULL,
[TransYear] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TransDate] [datetime] NULL,
[TransGroup] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TransType] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MatchingAcct] [int] NULL,
[MatchingTransID] [int] NULL,
[PaymentType] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CardType] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CardNo] [varchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ExpireDate] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CardHolderName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CardHolderAddress] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CardHolderZip] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AuthCode] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AuthTransID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CheckNo] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[notes] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[renew] [bit] NOT NULL,
[EnterDateTime] [datetime] NULL,
[EnterByUser] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BatchRefNo] [int] NULL,
[ReceiptID] [int] NULL,
[AltTransID1] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
ALTER TABLE [zzz].[dbo__ADV_ContactTransHeader_bkp_20170703] ADD CONSTRAINT [PK_ContactTransHeader] PRIMARY KEY CLUSTERED  ([TransID])
GO
CREATE NONCLUSTERED INDEX [IX_TransType_TransDate_i_TransID_ContactID_ReceiptID] ON [zzz].[dbo__ADV_ContactTransHeader_bkp_20170703] ([TransID], [ContactID], [ReceiptID], [TransType], [TransDate])
GO
CREATE NONCLUSTERED INDEX [IX_TransYear_TransType_i_TransID] ON [zzz].[dbo__ADV_ContactTransHeader_bkp_20170703] ([TransID], [TransYear], [TransType])
GO
