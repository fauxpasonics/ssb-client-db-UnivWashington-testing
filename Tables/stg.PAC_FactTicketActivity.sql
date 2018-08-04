CREATE TABLE [stg].[PAC_FactTicketActivity]
(
[ETL__ID] [bigint] NOT NULL IDENTITY(1, 1),
[ETL__SSID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL__SSID_PAC_SEASON] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CS_AS NOT NULL,
[ETL__SSID_PAC_TRANS_NO] [bigint] NOT NULL,
[DimDateId] [int] NOT NULL,
[DimTimeId] [int] NOT NULL,
[DimArenaId] [int] NOT NULL,
[DimSeasonId] [int] NOT NULL,
[DimItemId] [int] NOT NULL,
[DimEventId] [int] NOT NULL,
[DimPlanId] [int] NOT NULL,
[DimSeatId_Start] [int] NOT NULL,
[DimTicketCustomerId] [bigint] NOT NULL,
[DimTicketCustomerId_Recipient] [bigint] NOT NULL,
[DimActivityId] [int] NOT NULL,
[TransDateTime] [datetime] NULL,
[QtySeat] [int] NULL,
[SubTotal] [decimal] (18, 6) NULL,
[Fees] [decimal] (18, 6) NULL,
[Taxes] [decimal] (18, 6) NULL,
[Total] [decimal] (18, 6) NULL,
[UpdatedBy] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UpdatedDate] [datetime] NULL,
[PAC_MP_BOCHG] [decimal] (18, 6) NULL,
[PAC_MP_BUY_AMT] [decimal] (18, 6) NULL,
[PAC_MP_BUY_NET] [decimal] (18, 6) NULL,
[PAC_MP_BUYER] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PAC_MP_DIFF] [decimal] (18, 6) NULL,
[PAC_MP_DMETH_TYPE] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CS_AS NULL,
[PAC_MP_NETITEM] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CS_AS NULL,
[PAC_MP_OWNER] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PAC_MP_SELLCR] [decimal] (18, 6) NULL,
[PAC_MP_SELLER] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PAC_MP_SELLTIXAMT] [decimal] (18, 6) NULL,
[PAC_MP_SHPAID] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PAC_MP_SOCHG] [decimal] (18, 6) NULL,
[PAC_MP_TIXAMT] [decimal] (18, 6) NULL,
[PAC_MP_PL] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CS_AS NULL
)
GO
ALTER TABLE [stg].[PAC_FactTicketActivity] ADD CONSTRAINT [PK__PAC_Fact__C4EA2445AF4035A4] PRIMARY KEY CLUSTERED  ([ETL__ID])
GO
