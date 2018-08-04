CREATE TABLE [dbo].[ADV_PaymentSchedule]
(
[SchedID] [bigint] NOT NULL,
[SecondaryID] [bigint] NULL,
[ContactID] [bigint] NULL,
[ProgramID] [bigint] NULL,
[TransYear] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TransGroup] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TransAmount] [decimal] (18, 2) NULL,
[DateOfPayment] [datetime] NULL,
[MethodOfPayment] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TransactionCompleted] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ReceiptID] [int] NULL,
[NotesHeader] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LineItemComments] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SetupBy] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RolledOver] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EXPORT_DATETIME] [datetime] NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
ALTER TABLE [dbo].[ADV_PaymentSchedule] ADD CONSTRAINT [PK_ADV_PaymentSchedule] PRIMARY KEY CLUSTERED  ([SchedID])
GO
