CREATE TABLE [dbo].[ADV_HistoricalPriorityPoints]
(
[ContactID] [bigint] NOT NULL,
[EntryDate] [datetime] NOT NULL,
[Rank] [int] NULL,
[CurrYrCredits] [decimal] (18, 2) NULL,
[CurrYrPledges] [decimal] (18, 2) NULL,
[CurrYrReceipts] [decimal] (18, 2) NULL,
[PrevYrCredits] [decimal] (18, 2) NULL,
[PrevYrPledges] [decimal] (18, 2) NULL,
[PrevYrReceipts] [decimal] (18, 2) NULL,
[CurrYrCashPts] [float] NULL,
[PrevYrCashPts] [float] NULL,
[AccrualPts] [float] NULL,
[LinkedPriorityPts] [float] NULL,
[LinkedPriorityPtsGivenUp] [float] NULL,
[AccrualBasisPriorityPts] [float] NULL,
[CashBasisPriorityPts] [float] NULL,
[EXPORT_DATETIME] [datetime] NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
ALTER TABLE [dbo].[ADV_HistoricalPriorityPoints] ADD CONSTRAINT [PK_ADV_HistoricalPriorityPoints] PRIMARY KEY CLUSTERED  ([ContactID], [EntryDate])
GO
