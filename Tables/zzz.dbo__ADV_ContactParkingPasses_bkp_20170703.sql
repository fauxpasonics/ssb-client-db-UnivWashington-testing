CREATE TABLE [zzz].[dbo__ADV_ContactParkingPasses_bkp_20170703]
(
[PK] [int] NOT NULL,
[ContactID] [int] NULL,
[TicketNumber] [int] NULL,
[ParkingYear] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Sport] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[StallNumber] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LotNumber] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Quantity] [int] NULL,
[DisabilityTagNumber] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ParkingType] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Comments] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LineId] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Paid] [bit] NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
ALTER TABLE [zzz].[dbo__ADV_ContactParkingPasses_bkp_20170703] ADD CONSTRAINT [PK_ContactParkingPasses] PRIMARY KEY CLUSTERED  ([PK])
GO
CREATE NONCLUSTERED INDEX [IX_ContactID] ON [zzz].[dbo__ADV_ContactParkingPasses_bkp_20170703] ([ContactID], [ParkingYear], [Sport])
GO
CREATE NONCLUSTERED INDEX [IX_LineId] ON [zzz].[dbo__ADV_ContactParkingPasses_bkp_20170703] ([LineId])
GO
CREATE NONCLUSTERED INDEX [IX_ParkingYear_Sport] ON [zzz].[dbo__ADV_ContactParkingPasses_bkp_20170703] ([ParkingYear], [Sport])
GO
