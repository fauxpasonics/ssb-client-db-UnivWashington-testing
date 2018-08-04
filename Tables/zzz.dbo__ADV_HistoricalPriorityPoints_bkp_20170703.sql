CREATE TABLE [zzz].[dbo__ADV_HistoricalPriorityPoints_bkp_20170703]
(
[ContactID] [int] NOT NULL,
[EntryDate] [datetime] NOT NULL,
[Rank] [int] NULL,
[curr_yr_credits] [money] NULL,
[curr_yr_pledges] [money] NULL,
[curr_yr_receipts] [money] NULL,
[prev_yr_credits] [money] NULL,
[prev_yr_pledges] [money] NULL,
[prev_yr_receipts] [money] NULL,
[curr_yr_cash_pts] [int] NULL,
[prev_yr_cash_pts] [int] NULL,
[accrual_pts] [int] NULL,
[linked_ppts] [int] NULL,
[linked_ppts_given_up] [int] NULL,
[accrual_basis_ppts] [int] NULL,
[cash_basis_ppts] [int] NULL,
[LifetimeGiving] [money] NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
ALTER TABLE [zzz].[dbo__ADV_HistoricalPriorityPoints_bkp_20170703] ADD CONSTRAINT [PK_HistoricalPriorityPoints] PRIMARY KEY CLUSTERED  ([ContactID], [EntryDate])
GO
