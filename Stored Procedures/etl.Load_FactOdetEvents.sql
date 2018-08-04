SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- Stored Procedure

 


 
CREATE PROCEDURE [etl].[Load_FactOdetEvents] 
( 
	@BatchId UNIQUEIDENTIFIER = '00000000-0000-0000-0000-000000000000', 
	@Options NVARCHAR(max) = NULL 
) 
 
AS 
BEGIN 
 
 
 
--DECLARE @RunTime datetime = GETDATE() 
 
 
INSERT INTO dbo.FactOdet_V2 
(  
	ETL__SourceSystem, ETL__CreatedBy, ETL__CreatedDate, ETL__UpdatedDate, ETL__DeltaHashKey, ETL__SSID_PAC_CUSTOMER, ETL__SSID_PAC_SEASON, ETL__SSID_PAC_SEQ
	, DimDateId, DimTimeId, DimTicketCustomerId, DimArenaId
	, DimSeasonId, DimItemId, DimEventId, DimPlanId, DimPriceLevelId, DimPriceTypeId, DimPriceCodeId, DimSeatId_Start, DimRepId, DimSalesCodeId, DimPromoId, DimPlanTypeId, DimTicketTypeId, DimSeatTypeId, DimTicketClassId
	, QtySeat, QtySeatFSE, QtySeatRenewable
	, RevenueTicket, RevenueFees, RevenueSurcharge, RevenueTax, RevenueTotal
	, FullPrice, Discount, PaidStatus, PaidAmount, OwedAmount, PaymentDateFirst, PaymentDateLast
	, IsSold, IsReserved, IsReturned, IsPremium, IsDiscount, IsComp, IsHost, IsPlan, IsPartial, IsSingleEvent, IsGroup, IsBroker, IsRenewal, IsExpanded, InRefSource, InRefData
	
) 
 
SELECT  

	'PAC' ETL__SourceSystem , SUSER_NAME() ETL__CreatedBy, GETDATE() ETL__CreatedDate, GETDATE() ETL__UpdatedDate
	, CAST(NULL AS BINARY(32)) ETL__DeltaHashKey

	, tkt.CUSTOMER [ETL__SSID_PAC_CUSTOMER]
	, tkt.SEASON [ETL__SSID_PAC_SEASON] 
	, tkt.SEQ [ETL__SSID_PAC_SEQ] 
	 
	, CASE WHEN tkt.I_DATE IS NULL THEN 0 ELSE CONVERT(NVARCHAR(8), tkt.I_DATE, 112) END DimDateId 
	, CASE WHEN tkt.ORIGTS_DATETIME IS NULL THEN 0 ELSE datediff(second, cast(tkt.ORIGTS_DATETIME as date), tkt.ORIGTS_DATETIME) END DimTimeId 
	, ISNULL(dTicketCustomer.DimTicketCustomerId, -1) DimTicketCustomerId 
	, ISNULL(dArena.DimArenaId, -1) DimArenaId 
	, ISNULL(dSeason.DimSeasonId, -1)  DimSeasonId 
	, ISNULL(dItem.DimItemId, -1)  DimItemId 
	, ISNULL(dEvent.DimEventId, -1)  DimEventId 
	, CASE WHEN ISNULL(tkt.ITEM,'') = ISNULL(tkt.[EVENT],'') THEN 0 ELSE ISNULL(dplan.DimPlanId, -1) END DimPlanId 
	, ISNULL(dPriceLevel.DimPriceLevelId, -1)  DimPriceLevelId 
	, ISNULL(dPriceType.DimPriceTypeId, -1)  DimPriceTypeId 

	, -1 DimPriceCodeId 
	, -1 DimSeatId_Start 
	, -1 DimRepId 
	, -1 DimSalesCodeId 
	, -1 DimPromoId 
	, -1 DimPlanTypeId 
	, -1 DimTicketTypeId 
	, -1 DimSeatTypeId 
	, -1 DimTicketClassId 
 
	--, tkt.QtySeat QtySeat 
	--, tkt.OrderRevenue 
	--, tkt.OrderConvenienceFee  
	--, tkt.OrderFee 
	--, tkt.TotalRevenue TotalRevenue 
	--, NULL MinPaymentDate 
	--, tkt.PaidAmount 
	--, tkt.OwedAmount 
	--, tkt.FullPrice 
	--, tkt.Discount 

	, tkt.QtySeat
	, CAST(0 AS DECIMAL(18,6)) QtySeatFSE
	, CAST(0 AS INT) QtySeatRenewable

	, ISNULL(tkt.OrderRevenue,0) RevenueTicket
	, ISNULL(tkt.OrderFee, 0) RevenueFees
	, ISNULL(tkt.OrderConvenienceFee,0) RevenueSurcharge
	, CAST(0 AS DECIMAL(18,6)) RevenueTax	
	, tkt.TotalRevenue RevenueTotal 

	, tkt.FullPrice 
	, tkt.Discount

	, CASE 
		WHEN ISNULL(tkt.PaidAmount,0) >= tkt.TotalRevenue THEN 'Y'
		WHEN ISNULL(tkt.OwedAmount,0) > 0 THEN 'P'		
		ELSE 'N' 
	END  PaidStatus

	, tkt.PaidAmount 
	, tkt.OwedAmount 
	, NULL PaymentDateFirst
	, CAST(NULL AS DATETIME) PaymentDateLast
 
	, CAST(1 AS BIT) IsSold
	, CAST(0 AS BIT) IsReserved
	, CAST(0 AS BIT)  IsReturned
	, CAST(NULL AS BIT) IsPremium
	, CAST(NULL AS BIT)  IsDiscount
	, CAST(CASE WHEN tkt.TotalRevenue > 0 THEN 0 ELSE 1 END AS bit) IsComp
	, CAST(0 AS BIT) IsHost
	, CAST(CASE WHEN dplan.DimPlanId IS NULL THEN 0 ELSE 1 END AS bit) IsPlan
	, CAST(NULL AS BIT) IsPartial
	, CAST(CASE WHEN dplan.DimPlanId IS NULL THEN 1 ELSE 0 END AS bit) IsSingleEvent
	, CAST(NULL AS BIT) IsGroup
	, CAST(NULL AS BIT)  IsBroker
	, CAST(NULL AS BIT)  IsRenewal
	, CAST(NULL AS BIT)  IsExpanded
 
	, tkt.INREFSOURCE InRefSource 
	, tkt.INREFDATA InRefData 

 
--SELECT COUNT(*)
FROM etl.OdetEventBase (NOLOCK) tkt

LEFT OUTER JOIN dbo.DimSeason (NOLOCK) dSeason ON tkt.SEASON COLLATE SQL_Latin1_General_CP1_CS_AS = dSeason.ETL__SSID_PAC_SEASON
	 AND dSeason.ETL__SourceSystem = 'PAC' AND dSeason.DimSeasonId > 0 AND ISNULL(tkt.I_DATE, GETDATE()) BETWEEN dSeason.ETL__StartDate AND ISNULL(dSeason.ETL__EndDate, '3000-01-01')

LEFT OUTER JOIN dbo.DimTicketCustomer (NOLOCK) dTicketCustomer ON tkt.CUSTOMER = dTicketCustomer.ETL__SSID_PAC_PATRON
	AND dTicketCustomer.ETL__SourceSystem = 'PAC' AND dTicketCustomer.DimTicketCustomerId > 0 AND ISNULL(tkt.I_DATE, GETDATE()) BETWEEN dTicketCustomer.ETL__StartDate AND ISNULL(dTicketCustomer.ETL__EndDate, '3000-01-01')

LEFT OUTER JOIN dbo.DimItem (NOLOCK) dItem ON tkt.SEASON COLLATE SQL_Latin1_General_CP1_CS_AS = dItem.ETL__SSID_PAC_SEASON AND tkt.ITEM COLLATE SQL_Latin1_General_CP1_CS_AS = dItem.ETL__SSID_PAC_ITEM
	AND dItem.ETL__SourceSystem = 'PAC' AND dItem.DimItemId > 0 AND ISNULL(tkt.I_DATE, GETDATE()) BETWEEN dItem.ETL__StartDate AND ISNULL(dItem.ETL__EndDate, '3000-01-01')

LEFT OUTER JOIN dbo.DimEvent (NOLOCK) dEvent ON tkt.SEASON COLLATE SQL_Latin1_General_CP1_CS_AS = dEvent.ETL__SSID_PAC_SEASON AND tkt.[EVENT] COLLATE SQL_Latin1_General_CP1_CS_AS = dEvent.ETL__SSID_PAC_EVENT
	AND dEvent.ETL__SourceSystem = 'PAC' AND dEvent.DimEventId > 0 AND ISNULL(tkt.I_DATE, GETDATE()) BETWEEN dEvent.ETL__StartDate AND ISNULL(dEvent.ETL__EndDate, '3000-01-01')

LEFT OUTER JOIN dbo.DimPlan (NOLOCK) dplan ON tkt.SEASON COLLATE SQL_Latin1_General_CP1_CS_AS = dplan.ETL__SSID_PAC_SEASON AND tkt.[ITEM] COLLATE SQL_Latin1_General_CP1_CS_AS = dplan.ETL__SSID_PAC_ITEM
	AND dplan.ETL__SourceSystem = 'PAC' AND dplan.DimPlanId > 0 AND ISNULL(tkt.I_DATE, GETDATE()) BETWEEN dplan.ETL__StartDate AND ISNULL(dplan.ETL__EndDate, '3000-01-01')

LEFT OUTER JOIN dbo.DimArena (NOLOCK) dArena ON dEvent.Arena COLLATE SQL_Latin1_General_CP1_CS_AS = dArena.ETL__SSID_PAC_FACILITY
	AND dArena.ETL__SourceSystem = 'PAC' AND dArena.DimArenaId > 0 AND ISNULL(tkt.I_DATE, GETDATE()) BETWEEN dArena.ETL__StartDate AND ISNULL(dArena.ETL__EndDate, '3000-01-01')

LEFT OUTER JOIN dbo.TK_ITEM (NOLOCK) tkItem ON tkt.SEASON COLLATE SQL_Latin1_General_CP1_CS_AS = tkItem.SEASON AND tkt.ITEM COLLATE SQL_Latin1_General_CP1_CS_AS  = tkItem.ITEM

LEFT OUTER JOIN dbo.DimPriceLevel (NOLOCK) dPriceLevel ON tkt.SEASON COLLATE SQL_Latin1_General_CP1_CS_AS = dPriceLevel.ETL__SSID_PAC_SEASON AND tkItem.PTABLE COLLATE SQL_Latin1_General_CP1_CS_AS = dPriceLevel.ETL__SSID_PAC_PTable AND tkt.[E_PL] COLLATE SQL_Latin1_General_CP1_CS_AS = dPriceLevel.ETL__SSID_PAC_PL
	AND dPriceLevel.ETL__SourceSystem = 'PAC' AND dPriceLevel.DimPriceLevelId > 0 AND ISNULL(tkt.I_DATE, GETDATE()) BETWEEN dPriceLevel.ETL__StartDate AND ISNULL(dPriceLevel.ETL__EndDate, '3000-01-01')

LEFT OUTER JOIN dbo.DimPriceType (NOLOCK) dPriceType ON tkt.SEASON COLLATE SQL_Latin1_General_CP1_CS_AS = dPriceType.ETL__SSID_PAC_SEASON and tkt.[I_PT] COLLATE SQL_Latin1_General_CP1_CS_AS = dPriceType.ETL__SSID_PAC_PRTYPE
	AND dPriceType.ETL__SourceSystem = 'PAC' AND dPriceType.DimPriceTypeId > 0 AND ISNULL(tkt.I_DATE, GETDATE()) BETWEEN dPriceType.ETL__StartDate AND ISNULL(dPriceType.ETL__EndDate, '3000-01-01')

--WHERE tkt.SEASON = 'FB17' AND tkt.EVENT = 'FB06'


 
END 
 
 


GO
