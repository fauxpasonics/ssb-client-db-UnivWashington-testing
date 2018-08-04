SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO









CREATE VIEW [ro].[vw_FactTicketSalesBase] AS (

SELECT

ISNULL(f.OrderDate, f.CreatedDate) TransDateTime
, dtCust.ETL__SSID TicketingAccountId
, f.ETL__SourceSystem
, da.ArenaName
--, dsh.SeasonName SeasonHeaderName, dsh.SeasonClass SeasonHeaderClass, dsh.SeasonYear SeasonHeaderYear, dsh.Active SeasonHeaderIsActive
, ds.SeasonCode, ds.SeasonName, ds.SeasonYear, ds.SeasonClass, ds.Config_Org AS Sport
--, deh.EventName EventHeaderName, deh.EventDesc EventHeaderDesc, deh.EventDateTime EventHeaderDateTime, deh.EventDate EventHeaderDate, deh.EventTime EventHeaderTime, deh.EventHierarchyL1, deh.EventHierarchyL2, deh.EventHierarchyL3
, de.EventCode, de.EventName, de.EventDesc, de.EventClass, de.EventDateTime, de.EventDate, de.EventTime, de.PAC_EGROUP
, di.ItemCode, di.ItemName
, dpl.PlanCode, dpl.PlanName, dpl.PlanClass, dpl.PlanFse, dpl.PlanEventCnt
, dst.SectionName, dst.RowName, dst.Seat, dst.Config_Location SeatLocationMapping
, dpc.PriceCode, dpc.pc1, dpc.PC2, dpc.PC3, dpc.PC4, dpc.PriceCodeDesc, dpc.PriceCodeGroup
, dprt.PriceTypeCode, dprt.PriceTypeName, dprt.PriceTypeClass
, dprl.PriceLevelCode, dprl.PriceLevelName

, dtc.TicketClassCode, dtc.TicketClassName
, dtt.TicketTypeCode, dtt.TicketTypeName, dtt.TicketTypeClass
, dpt.PlanTypeCode, dpt.PlanTypeName
, dstp.SeatTypeCode, dstp.SeatTypeName
, dsc.SalesCode, dsc.SalesCodeName
, dpm.PromoCode, dpm.PromoName

, f.TM_Order_Num, f.TM_Order_Line_Item, f.TM_Order_Line_Item_Seq
, f.QtySeat, f.QtySeatFSE, f.QtySeatRenewable
, f.RevenueTotal, f.RevenueTicket, RevenueFees

, f.TM_purchase_price, f.TM_block_purchase_price, f.TM_pc_ticket BlockPcTicket, f.TM_Pc_Tax BlockPcTax, f.TM_pc_licfee BlockPcLicenseFee, f.TM_Pc_Other1 BlockPcOther1, f.TM_Pc_Other2 BlockPcOther2
, f.PaidAmount, f.OwedAmount, f.PaidStatus
, f.IsPremium, f.IsComp, f.IsHost, f.IsPlan, f.IsPartial, f.IsSingleEvent, f.IsGroup, f.IsBroker, f.IsRenewal, f.IsExpanded, f.IsAutoRenewalNextSeason

, f.TM_comp_code, f.TM_comp_name, f.TM_group_sales_name, f.TM_ticket_type, f.TM_tran_type, f.TM_sales_source_name, f.TM_retail_ticket_type, f.TM_retail_qualifiers

, f.FactTicketSalesId, f.DimDateId, f.DimTimeId, f.DimTicketCustomerId, f.DimArenaId, f.DimSeasonId, f.DimItemId, f.DimEventId, f.DimPlanId
, f.DimPriceCodeId, f.DimSeatId_Start, f.DimSalesCodeId, f.DimPromoId
,  f.DimTicketTypeId, f.DimPlanTypeId, f.DimSeatTypeId, f.DimTicketClassId
, f.DimRepId
, f.TM_ticket_seq_id

--SELECT COUNT(*) 
FROM ro.vw_FactTicketSales f
INNER JOIN ro.vw_DimArena da ON f.DimArenaId = da.DimArenaId
INNER JOIN ro.vw_DimSeason ds ON f.DimSeasonId = ds.DimSeasonId
INNER JOIN ro.vw_DimItem di ON f.DimItemId = di.DimItemId
INNER JOIN ro.vw_DimEvent de ON f.DimEventId = de.DimEventId
INNER JOIN ro.vw_DimTicketCustomer dtCust ON f.DimTicketCustomerId = dtCust.DimTicketCustomerId
--INNER JOIN dbo.DimEventHeader deh ON de.DimEventHeaderId = deh.DimEventHeaderId
--INNER JOIN dbo.DimSeasonHeader dsh ON deh.DimSeasonHeaderId = dsh.DimSeasonHeaderId

--change joins below to inner joins once Dims are confirmed
INNER JOIN ro.vw_DimPlan dpl ON f.DimPlanId = dpl.DimPlanId
INNER JOIN ro.vw_DimPriceCode dpc ON f.DimPriceCodeId = dpc.DimPriceCodeId
INNER JOIN ro.vw_DimTicketClass dtc ON f.DimTicketClassId = dtc.DimTicketClassId
INNER JOIN ro.vw_DimTicketType dtt ON f.DimTicketTypeId = dtt.DimTicketTypeId
INNER JOIN ro.vw_DimPlanType dpt ON f.DimPlanTypeId = dpt.DimPlanTypeId
INNER JOIN ro.vw_DimSeatType dstp ON f.DimSeatTypeId = dstp.DimSeatTypeId
INNER JOIN ro.vw_DimSalesCode dsc ON f.DimSalesCodeId = dsc.DimSalesCodeId
INNER JOIN ro.vw_DimPromo dpm ON f.DimPromoId = dpm.DimPromoID
INNER JOIN ro.vw_DimSeat dst ON f.DimSeatId_Start = dst.DimSeatId
INNER JOIN ro.vw_DimPriceType dprt ON f.DimPriceTypeId = dprt.DimPriceTypeId
INNER JOIN ro.vw_DimPriceLevel dprl ON f.DimPriceLevelId = dprl.DimPriceLevelId


)






GO
