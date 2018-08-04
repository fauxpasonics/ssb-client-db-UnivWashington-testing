CREATE TABLE [dbo].[ADV_ContactParkingPasses]
(
[PrimaryKey] [bigint] NOT NULL,
[ContactID] [bigint] NULL,
[PatronID] [bigint] NULL,
[ParkingYear] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Sport] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[StallNumber] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LotNumber] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Quantity] [int] NULL,
[ParkingType] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EXPORT_DATETIME] [datetime] NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
ALTER TABLE [dbo].[ADV_ContactParkingPasses] ADD CONSTRAINT [PK_ADV_ContactParkingPasses] PRIMARY KEY CLUSTERED  ([PrimaryKey])
GO
