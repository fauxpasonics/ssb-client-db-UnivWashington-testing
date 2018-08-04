CREATE TABLE [etl].[testzfnow]
(
[SEASON] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CS_AS NULL,
[CUSTOMER] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CS_AS NULL,
[CUSTOMER_TYPE] [varchar] (32) COLLATE SQL_Latin1_General_CP1_CS_AS NULL,
[ITEM] [varchar] (32) COLLATE SQL_Latin1_General_CP1_CS_AS NULL,
[E_PL] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CS_AS NULL,
[I_PT] [varchar] (32) COLLATE SQL_Latin1_General_CP1_CS_AS NULL,
[I_PRICE] [numeric] (18, 2) NULL,
[I_DAMT] [numeric] (18, 2) NULL,
[ORDQTY] [bigint] NULL,
[ORDTOTAL] [numeric] (18, 2) NULL,
[PAIDCUSTOMER] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CS_AS NULL,
[MINPAYMENTDATE] [datetime] NULL,
[PAIDTOTAL] [numeric] (18, 2) NOT NULL,
[INSERTDATE] [datetime] NOT NULL
)
GO
