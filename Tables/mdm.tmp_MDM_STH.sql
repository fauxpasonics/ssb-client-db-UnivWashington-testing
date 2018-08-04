CREATE TABLE [mdm].[tmp_MDM_STH]
(
[dimcustomerid] [int] NOT NULL,
[DNR] [int] NULL,
[STH] [int] NULL,
[MaxSeatCount] [int] NULL,
[maxPurchaseDate] [datetime] NULL,
[accountid] [int] NULL
)
GO
CREATE CLUSTERED INDEX [ix_MDM_STH] ON [mdm].[tmp_MDM_STH] ([dimcustomerid])
GO
