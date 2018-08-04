SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





CREATE VIEW [ro].[vw_FactTicketSeat] AS (

SELECT 
    --fi.*, 
	--fo.*,
	--ftar.*,
	dd.CalDate SaleDate, dt.Time24 SaleTime, ( CAST(dd.CalDate AS DATETIME) + CAST(dt.Time24 AS DATETIME) ) SaleDateTime
    , fo.[ETL__SSID_PAC_CUSTOMER] AS TicketingAccountId
	
	, da.ArenaCode, da.ArenaName
	--, dsh.SeasonCode SeasonHeaderCode, dsh.SeasonName SeasonHeaderName, dsh.SeasonDesc SeasonHeaderDesc, dsh.SeasonClass SeasonHeaderClass, dsh.SeasonYear SeasonHeaderYear, dsh.Active SeasonHeaderIsActive
	, ds.SeasonName, ds.SeasonYear, ds.SeasonClass, ds.Config_Org Sport
	--, deh.EventName EventHeaderName, deh.EventDesc EventHeaderDesc, deh.EventDate EventHeaderDate, deh.EventTime EventHeaderTime, deh.EventDateTime EventHeaderDateTime, deh.EventOpenTime EventHeaderOpenTime, deh.EventFinishTime EventHeaderFinishTime, deh.EventSeasonNumber EventSeasonNumber, deh.HomeGameNumber EventHeaderHomeNumber, deh.GameNumber EventHeaderGameNumber, deh.EventHierarchyL1, deh.EventHierarchyL2, deh.EventHierarchyL3, deh.EventHierarchyL4, deh.EventHierarchyL5
    , de.EventCode, de.EventName, de.EventDate, de.EventTime, de.EventDateTime
	, dss.SeatStatusCode, dss.SeatStatusName, dss.[Custom_Bit_1] 
	, di.ItemCode, di.ItemName
	, dpl.PlanCode, dpl.PlanName, dpl.PlanDesc, dpl.PlanClass, dpl.PlanFse, dpl.PlanType, dpl.PlanEventCnt
	, dpt.PriceTypeCode, PriceTypeName, PriceTypeClass
	, dst.SectionName, dst.RowName, dst.Seat
	--, dst.Config_Location SeatLocationMapping, dst.IsDeleted
	, dtc.TicketClassCode, dtc.TicketClassName
	, tt.TicketTypeCode, tt.TicketTypeName, tt.TicketTypeDesc
	, pt.PlanTypeCode, pt.PlanTypeName, pt.PlanTypeDesc
	, dstp.SeatTypeCode, dstp.SeatTypeName
	--, dctm.ClassName, dctm.DistStatus
	, dsc.SalesCode, dsc.SalesCodeName
	, dpm.PromoCode, dpm.PromoName


	--, fi.IsSaleable
	--, fi.IsAvailable
	--, fi.IsHeld
	--, fi.IsReserved
	
	, fo.IsSold
	--, fi.IsHost
	, fo.IsComp
	
	, fo.IsPremium
	, fo.IsSingleEvent
	, fo.IsPlan
	, fo.IsPartial
    , fo.IsGroup
	, fo.IsRenewal
	, fo.IsBroker

	--, fi.IsAttended
	--, fi.ScanDateTime
	--, fi.ScanGate

	, CASE WHEN fo.IsSold = 1 THEN 1 ELSE 0 END AS QtySeat
	, fo.RevenueTotal/NULLIF(fo.QtySeat,0) AS RevenueTotal
	, fo.PaidAmount/NULLIF(fo.QtySeat,0) AS PaidAmound
	, fo.OwedAmount/NULLIF(fo.QtySeat,0) AS OwedAmount


	, CASE WHEN ftar.FactTicketActivityId IS NULL THEN 0 ELSE 1 END AS IsResold
	, ( CAST(dd_resold.CalDate AS DATETIME) + CAST(dt_resold.Time24 AS DATETIME) ) ResoldDateTime
	--, ftar.ResoldPurchasePrice
	--, ftar.Fees ResoldFees
	,ftar.QtySeat ResoldQty
	, ftar.Total/ftar.QtySeat ResoldTotal
	, ftar.PAC_MP_Diff/ftar.QtySeat ResoldDifference
	, ftar.PAC_MP_Buy_Amt/ftar.QtySeat ResoldValue
	, ftar.PAC_MP_Buyer ResoldBuyer_TicketingAccountId

	, fi.FactInventoryId, fi.FactOdetId, fi.[FactTicketActivityId_Tranferred], fi.FactAvailSeatsId, fi.FactHeldSeatsId, fi.DimSeasonId, fi.DimEventId, fi.DimSeatId, fi.DimSeatStatusid
	, dc.SSB_CRMSYSTEM_CONTACT_ID


FROM [ro].[vw_FactInventory] fi 

INNER JOIN [ro].[vw_DimSeason] ds ON fi.DimSeasonId = ds.DimSeasonId
INNER JOIN [ro].[vw_DimArena] da ON fi.DimArenaId = da.DimArenaId
INNER JOIN [ro].[vw_DimEvent] de ON fi.DimEventId = de.DimEventId
--INNER JOIN dbo.DimEventHeader (NOLOCK) deh ON de.DimEventHeaderId = deh.DimEventHeaderId
--INNER JOIN dbo.DimSeasonHeader (NOLOCK) dsh ON deh.DimSeasonHeaderId = dsh.DimSeasonHeaderId
INNER JOIN [ro].[vw_DimSeat] dst ON fi.DimSeatId = dst.DimSeatId
INNER JOIN [ro].[vw_DimSeatStatus] dss ON fi.DimSeatStatusid = dss.DimseatStatusId


LEFT OUTER JOIN [ro].[vw_FactOdet] fo ON fi.FactOdetId = fo.FactOdetId
LEFT OUTER JOIN [ro].[vw_FactTicketActivity] ftar ON fi.FactTicketActivityId_Resold = ftar.FactTicketActivityId
LEFT OUTER JOIN [ro].[vw_DimPriceType] dpt ON fo.DimPriceTypeId = dpt.DimPriceTypeId
LEFT OUTER JOIN [ro].[vw_DimItem] di ON fo.DimItemId = di.DimItemId
LEFT OUTER JOIN [ro].[vw_DimPlan] dpl ON fo.DimPlanId = dpl.DimPlanId 
LEFT OUTER JOIN [dbo].[vwDimCustomer_ModAcctId] dc ON dc.SourceSystem = 'Paciolan' AND fo.ETL__SSID_PAC_CUSTOMER = dc.SSID
    
LEFT OUTER JOIN dbo.DimDate (NOLOCK) dd ON fo.DimDateId = dd.DimDateId
LEFT OUTER JOIN dbo.DimTime (NOLOCK) dt ON fo.DimTimeId = dt.DimTimeId

LEFT OUTER JOIN dbo.DimDate (NOLOCK) dd_resold ON ftar.DimdateId = dd_resold.DimDateId
LEFT OUTER JOIN dbo.DimTime (NOLOCK) dt_resold ON ftar.DimTimeId = dt_resold.DimTimeId


LEFT OUTER JOIN [ro].[vw_DimSalesCode] dsc ON fo.DimSalesCodeId = dsc.DimSalesCodeId
LEFT OUTER JOIN [ro].[vw_DimPromo] dpm ON fo.DimPromoId = dpm.DimPromoID
LEFT OUTER JOIN [ro].[vw_DimPlanType] pt ON fo.DimPlanTypeId = pt.DimPlanTypeId
LEFT OUTER JOIN [ro].[vw_DimTicketType] tt ON fo.DimTicketTypeId = tt.DimTicketTypeId
LEFT OUTER JOIN [ro].[vw_DimSeatType] dstp ON fo.DimSeatTypeId = dstp.DimSeatTypeId
LEFT OUTER JOIN [ro].[vw_DimTicketClass] dtc ON fo.DimTicketClassId = dtc.DimTicketClassId


)
GO
