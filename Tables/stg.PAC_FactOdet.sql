CREATE TABLE [stg].[PAC_FactOdet]
(
[ETL__ID] [bigint] NOT NULL IDENTITY(1, 1),
[ETL__SSID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL__SSID_PAC_CUSTOMER] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL__SSID_PAC_SEASON] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CS_AS NULL,
[ETL__SSID_PAC_SEQ] [bigint] NULL,
[ETL__SSID_PAC_VMC] [bigint] NULL,
[ETL__SSID_PAC_SVMC] [bigint] NULL,
[DimDateId] [int] NOT NULL,
[DimTimeId] [int] NOT NULL,
[DimTicketCustomerId] [bigint] NOT NULL,
[DimArenaId] [int] NOT NULL,
[DimSeasonId] [int] NOT NULL,
[DimItemId] [int] NOT NULL,
[DimEventId] [int] NOT NULL,
[DimPlanId] [int] NOT NULL,
[DimPriceLevelId] [int] NOT NULL,
[DimPriceTypeId] [int] NOT NULL,
[DimPriceCodeId] [int] NOT NULL,
[DimSeatId_Start] [int] NOT NULL,
[DimRepId] [int] NOT NULL,
[DimSalesCodeId] [int] NOT NULL,
[DimPromoId] [int] NOT NULL,
[DimPlanTypeId] [int] NOT NULL,
[DimTicketTypeId] [int] NOT NULL,
[DimSeatTypeId] [int] NOT NULL,
[DimTicketClassId] [int] NOT NULL,
[OrderDate] [datetime] NULL,
[SSCreatedBy] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SSUpdatedBy] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SSCreatedDate] [datetime] NULL,
[SSUpdatedDate] [datetime] NULL,
[QtySeat] [int] NULL,
[QtySeatFSE] [decimal] (18, 6) NULL,
[QtySeatRenewable] [int] NULL,
[RevenueTicket] [decimal] (18, 6) NULL,
[RevenueFees] [decimal] (18, 6) NULL,
[RevenueSurcharge] [decimal] (18, 6) NULL,
[RevenueTax] [decimal] (18, 6) NULL,
[RevenueTotal] [decimal] (18, 6) NULL,
[FullPrice] [decimal] (18, 6) NULL,
[Discount] [decimal] (18, 6) NULL,
[PaidStatus] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PaidAmount] [decimal] (18, 6) NULL,
[OwedAmount] [decimal] (18, 6) NULL,
[PaymentDateFirst] [datetime] NULL,
[PaymentDateLast] [datetime] NULL,
[IsSold] [bit] NULL,
[IsReserved] [bit] NULL,
[IsReturned] [bit] NULL,
[IsPremium] [bit] NULL,
[IsDiscount] [bit] NULL,
[IsComp] [bit] NULL,
[IsHost] [bit] NULL,
[IsPlan] [bit] NULL,
[IsPartial] [bit] NULL,
[IsSingleEvent] [bit] NULL,
[IsGroup] [bit] NULL,
[IsBroker] [bit] NULL,
[IsRenewal] [bit] NULL,
[IsExpanded] [bit] NULL,
[InRefSource] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[InRefData] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Custom_Int_1] [int] NULL,
[Custom_Int_2] [int] NULL,
[Custom_Int_3] [int] NULL,
[Custom_Int_4] [int] NULL,
[Custom_Int_5] [int] NULL,
[Custom_Dec_1] [decimal] (18, 6) NULL,
[Custom_Dec_2] [decimal] (18, 6) NULL,
[Custom_Dec_3] [decimal] (18, 6) NULL,
[Custom_Dec_4] [decimal] (18, 6) NULL,
[Custom_Dec_5] [decimal] (18, 6) NULL,
[Custom_DateTime_1] [datetime] NULL,
[Custom_DateTime_2] [datetime] NULL,
[Custom_DateTime_3] [datetime] NULL,
[Custom_DateTime_4] [datetime] NULL,
[Custom_DateTime_5] [datetime] NULL,
[Custom_Bit_1] [bit] NULL,
[Custom_Bit_2] [bit] NULL,
[Custom_Bit_3] [bit] NULL,
[Custom_Bit_4] [bit] NULL,
[Custom_Bit_5] [bit] NULL,
[Custom_nVarChar_1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Custom_nVarChar_2] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Custom_nVarChar_3] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Custom_nVarChar_4] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Custom_nVarChar_5] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CreatedBy] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UpdatedBy] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CreatedDate] [datetime] NULL,
[UpdatedDate] [datetime] NULL
)
GO
ALTER TABLE [stg].[PAC_FactOdet] ADD CONSTRAINT [PK_stg__PAC_FactOdet] PRIMARY KEY CLUSTERED  ([ETL__ID])
GO
