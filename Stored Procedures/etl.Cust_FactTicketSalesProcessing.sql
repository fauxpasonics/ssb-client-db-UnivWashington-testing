SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
 
-- =============================================
-- Created By: Abbey Meitin
-- Create Date: 2017/07/23
-- Reviewed By: Payton Soicher
-- Reviewed Date: 2018/07/11
-- Description: FactTicketSales BusinessRules
-- =============================================
  
/***** Revision History
  
Abbey Meitin: 2018-06-08: Added Temporary Season Ticket item logic

Payton Soicher: 2018-07-12: Made update to Full Season tickets so it doesnt look at Husky Passes
							Made update statement for Husky Passes

Abbey Meitin: 2018-08-01: Adjusted Temporary Season Ticket item logic to only look at SEA price type class; Reviewed By Payton Soicher

*****/
 
CREATE PROCEDURE [etl].[Cust_FactTicketSalesProcessing]
(
    @BatchId INT = 0,
    @LoadDate DATETIME = NULL,
    @Options NVARCHAR(MAX) = NULL
)
AS
 
BEGIN
 
 
/*****************************************************************************************************************
                                                    TICKET TYPE
******************************************************************************************************************/
 
--------------FULL SEASON --------------------------------
 
UPDATE fts
SET fts.DimTicketTypeId = 1
FROM     stg.FactTicketSales_V2 fts 
        INNER JOIN dbo.DimPriceType_V2 dpt (NOLOCK)
            ON fts.DimPriceTypeId = dpt.DimPriceTypeId
		INNER JOIN dbo.DimItem_V2 di ON di.DimItemId = fts.DimItemId
WHERE dpt.PriceTypeClass = 'SEA'
AND ItemCode <> 'HP'


 
--------------TEMPORARY SEASON TICKETS ----- added 2018-076-08 by Ameitin
 
UPDATE fts
SET fts.DimTicketTypeId = 27
FROM     stg.FactTicketSales_V2 fts 
        INNER JOIN dbo.DimItem_V2 di (NOLOCK) 
            ON fts.DimItemId = di.DimItemId
		INNER JOIN dbo.DimPriceType_V2 dpt (NOLOCK) --added join 2018-08-01 by AMeitin
            ON fts.DimPriceTypeId = dpt.DimPriceTypeId
WHERE di.ItemCode IN ('FSVB', 'FSMB', 'FSWB', 'FSSB', 'FSBS', 'FSMS','FSWS')
AND dpt.PriceTypeClass = 'SEA' --added join 2018-08-01 by AMeitin
 
 
 
--------------PARTIALS--------------------------------
 
UPDATE fts
SET fts.DimTicketTypeId = 2
FROM     stg.FactTicketSales_V2 fts 
        INNER JOIN dbo.DimPriceType_V2 dpt (NOLOCK) 
            ON fts.DimPriceTypeId = dpt.DimPriceTypeId
WHERE dpt.PriceTypeClass = 'PART'
 
 
 
--------------GROUP--------------------------------
 
UPDATE fts
SET fts.DimTicketTypeId = 3
FROM     stg.FactTicketSales_V2 fts 
        INNER JOIN dbo.DimPriceType_V2 dpt (NOLOCK) 
            ON fts.DimPriceTypeId = dpt.DimPriceTypeId
WHERE  dpt.PriceTypeClass = 'GRP'
AND fts.DimPromoId = 0
 
 
--------------GROUP PROMO--------------------------------
 
UPDATE fts
SET fts.DimTicketTypeId = 4
FROM     stg.FactTicketSales_V2 fts 
        INNER JOIN dbo.DimPriceType_V2 dpt (NOLOCK) 
            ON fts.DimPriceTypeId = dpt.DimPriceTypeId
WHERE  dpt.PriceTypeClass = 'GRP'
AND fts.DimPromoId <> 0
 
 
 
--------------SINGLE GAME-------------------------------
 
UPDATE fts
SET fts.DimTicketTypeId = 5
FROM    stg.FactTicketSales_V2 fts 
        INNER JOIN dbo.DimPriceType_V2 dpt (NOLOCK) 
            ON fts.DimPriceTypeId = dpt.DimPriceTypeId
        INNER JOIN dbo.Dimevent_V2 de (NOLOCK) 
            ON fts.DimEventId = de.DimEventId
WHERE  dpt.PriceTypeClass = 'SING'
AND de.PAC_EGROUP = 'H'
AND fts.DimPromoId <= 0
 
 
 
 
--------------SINGLE GAME PROMOTIONS-------------------------------
 
 
UPDATE fts
SET fts.DimTicketTypeId = 6
FROM stg.FactTicketSales_V2 fts 
        INNER JOIN dbo.DimPriceType_V2 dpt (NOLOCK) 
            ON fts.DimPriceTypeId = dpt.DimPriceTypeId
        INNER JOIN dbo.Dimevent_V2 de (NOLOCK) 
            ON fts.DimEventId = de.DimEventId
WHERE  dpt.PriceTypeClass = 'SING'
AND de.PAC_EGROUP = 'H'
AND fts.DimPromoId > 0
 
 
--------------Visitor Tickets-------------------------------
 
UPDATE fts
SET fts.DimTicketTypeId = 7
FROM     stg.FactTicketSales_V2 fts 
        INNER JOIN dbo.DimPriceType_V2 dpt (NOLOCK) 
            ON fts.DimPriceTypeId = dpt.DimPriceTypeId
WHERE  dpt.PriceTypeClass = 'VIS'
 
 
--------------StubHub Direct Lists------------------------------
 
UPDATE fts
SET fts.DimTicketTypeId = 26
FROM     stg.FactTicketSales_V2 fts 
        INNER JOIN dbo.DimPriceType_V2 dpt (NOLOCK) 
            ON fts.DimPriceTypeId = dpt.DimPriceTypeId
WHERE  dpt.PriceTypeClass = 'SHDI'
 
 
--------------Dawg Pack (aka Student Tickets)-------------------------------
UPDATE fts
SET fts.DimTicketTypeId = 8
FROM     stg.FactTicketSales_V2  fts
        INNER JOIN dbo.DimPriceType_V2 dpt (NOLOCK) 
            ON fts.DimPriceTypeId = dpt.DimPriceTypeId
        INNER JOIN dbo.DimPlan_V2 dpl (NOLOCK) 
            on fts.DimPlanId = dpl.DimPlanId
WHERE  dpt.PriceTypeClass = 'DP'
AND dpl.PlanCode = 'DP'
 
 
--------------COMPS-------------------------------
UPDATE fts
SET fts.DimTicketTypeId = 24
FROM     stg.FactTicketSales_V2 fts 
        INNER JOIN dbo.DimPriceType_V2 dpt (NOLOCK) 
            ON fts.DimPriceTypeId = dpt.DimPriceTypeId
WHERE  dpt.PriceTypeClass = 'COMP'
 
 
 
--------------Parking-------------------------------
UPDATE fts
SET fts.DimTicketTypeId = 9
FROM    stg.FactTicketSales_V2  fts
INNER JOIN dbo.DimEvent_V2 de (NOLOCK) 
    on fts.DimEventId = de.DimEventId
INNER JOIN dbo.DimSeason_V2 ds (NOLOCK) 
    on fts.DimSeasonId = ds.DimSeasonId
--INNER JOIN dbo.DimItem_V2 di on fts.DimItemId = di.DimItemId
Where 1=1
AND PAC_EGROUP = 'P'
 
 
--------------Seat Cushions-------------------------------
UPDATE fts
SET fts.DimTicketTypeId = 10
FROM     stg.FactTicketSales_V2  fts
INNER JOIN dbo.DimEvent_V2 de (NOLOCK) 
    ON fts.DimEventId = de.DimEventId
Where 1=1
AND PAC_EGROUP = 'SC'
 
 
--------------Bus Passes-------------------------------
UPDATE fts
SET fts.DimTicketTypeId = 11
FROM     stg.FactTicketSales_V2  fts
INNER JOIN dbo.DimEvent_V2 de (NOLOCK) 
    on fts.DimEventId = de.DimEventId
Where 1=1
AND PAC_EGROUP = 'TB'
 
--------------Seat Deposit-------------------------------
UPDATE fts
SET fts.DimTicketTypeId = 12
FROM    stg.FactTicketSales_V2  fts
        INNER JOIN dbo.DimItem_V2 di (NOLOCK) 
            ON fts.DimItemId = di.DimItemId
WHERE 1=1
AND di.ItemClass = 'FSDEP'
 
 
 
--------------Group Deposit-------------------------------
UPDATE fts
SET fts.DimTicketTypeId = 13
FROM    stg.FactTicketSales_V2  fts
        INNER JOIN dbo.DimItem_V2 di (NOLOCK) 
            ON fts.DimItemId = di.DimItemId
WHERE 1=1
AND di.ItemClass = 'GPDEP'
 
 
--------------Partial Deposit-------------------------------
UPDATE fts
SET fts.DimTicketTypeId = 23
FROM    stg.FactTicketSales_V2  fts
        INNER JOIN dbo.DimItem_V2 di (NOLOCK) 
            ON fts.DimItemId = di.DimItemId
WHERE 1=1
AND di.ItemClass = 'PPDEP'
 
 
--------------PostSeason-------------------------------
UPDATE fts
SET fts.DimTicketTypeId = 14
FROM    stg.FactTicketSales_V2  fts
INNER JOIN dbo.DimEvent_V2 de (NOLOCK) 
    on fts.DimEventId = de.DimEventId
INNER JOIN dbo.DimSeason_V2 ds (NOLOCK) 
    on fts.DimSeasonId = ds.DimSeasonId
Where 1=1
AND de.PAC_EGROUP = 'PS'
 
 
 
--------------Ticket Package-------------------------------
--UPDATE fts
--SET fts.DimTicketTypeId = 15
--FROM    #stgFactTicketSales  fts
--      INNER JOIN dbo.DimSeason ds ON fts.DimSeasonId = ds.DimSeasonId
--      INNER JOIN dbo.DimPriceCode pc ON fts.DimPriceCodeId = pc.DimPriceCodeId
--WHERE 1=1
--AND ds.SeasonName LIKE '%PostSeason%' 
 
 
--------------Away Games-------------------------------
UPDATE fts
SET fts.DimTicketTypeId = 16
FROM     stg.FactTicketSales_V2  fts
INNER JOIN dbo.DimEvent_V2 de (NOLOCK) 
    on fts.DimEventId = de.DimEventId
Where 1=1
AND PAC_EGROUP = 'A'
 
 
 
--------------Miscellaneous-------------------------------
UPDATE fts
SET fts.DimTicketTypeId = 17
FROM    stg.FactTicketSales_V2  fts
        INNER JOIN dbo.DimItem_V2 di (NOLOCK) 
            ON fts.DimItemId = di.DimItemId
WHERE 1=1
AND di.PAC_BASIS = 'M'
AND ItemClass NOT LIKE '%DEP'
 
 
--------------BFE Contribution-------------------------------
UPDATE fts
SET fts.DimTicketTypeId = 20
FROM     stg.FactTicketSales_V2  fts
INNER JOIN dbo.DimEvent_V2 de (NOLOCK) 
    on fts.DimEventId = de.DimEventId
Where 1=1
AND PAC_EGROUP = 'BFE'
 
--------------Zone Pass-------------------------------
UPDATE fts
SET fts.DimTicketTypeId = 25
FROM  stg.FactTicketSales_V2  fts
INNER JOIN dbo.DimEvent_V2 de (NOLOCK) 
    on fts.DimEventId = de.DimEventId
Where 1=1
AND PAC_EGROUP = 'ZP'
 
--------------HUsky Gold Card-------------------------------
UPDATE fts
SET fts.DimTicketTypeId = 19
FROM     stg.FactTicketSales_V2  fts (NOLOCK)
INNER JOIN dbo.DimItem_V2 di (NOLOCK)
    on fts.DimItemId = di.DimItemId
Where 1=1
AND ItemCode = 'HGC'

--  ==================================================================
--  7/12/2018 10:53 AM
--  Payton Soicher
--  Subject: Husky Pass
--  ==================================================================
--------------Husky Pass-------------------------------

UPDATE fts
SET fts.DimTicketTypeId = (SELECT DimTicketTypeId FROM dbo.DimTicketType_V2 WHERE TicketTypeCode = 'HP')
FROM stg.FactTicketSales_V2 fts (NOLOCK)
INNER JOIN dbo.DimItem_V2 di (NOLOCK) ON di.DimItemId = fts.DimItemId
WHERE di.ItemCode = 'HP'

 
 
 
--------------Dawg Pack Singles  (aka Student Tickets)-------------------------------
UPDATE fts
SET fts.DimTicketTypeId = 22
FROM     stg.FactTicketSales_V2  fts 
        INNER JOIN dbo.DimPriceType_V2 dpt (NOLOCK) 
            ON fts.DimPriceTypeId = dpt.DimPriceTypeId
        INNER JOIN dbo.DimItem_V2 di (NOLOCK) 
            on fts.DimItemId = di.DimItemId
WHERE  dpt.PriceTypeClass = 'DP'
AND di.PAC_BASIS = 'S'
 
UPDATE fts
SET fts.DimTicketTypeId = 22
FROM     stg.FactTicketSales_V2  fts
        INNER JOIN dbo.DimPriceType_V2 dpt (NOLOCK) 
            ON fts.DimPriceTypeId = dpt.DimPriceTypeId
        INNER JOIN dbo.DimItem_V2 di (NOLOCK) 
            on fts.DimItemId = di.DimItemId
WHERE  di.PAC_BASIS = 'S'
AND dpt.PriceTypeCode = 'CDP'
 
--Manual Overrides
UPDATE fts
SET fts.DimTicketTypeId = 8
FROM     stg.FactTicketSales_V2  fts
        INNER JOIN dbo.DimPriceType_V2 dpt ON fts.DimPriceTypeId = dpt.DimPriceTypeId
        INNER JOIN dbo.DimPriceLevel_V2 dprl on fts.DimPriceLevelId = dprl.DimpriceLevelId
WHERE  dpt.PriceTypeCode = 'C'
AND dprl.PriceLevelCode IN ('17', '18')
AND DimSeasonId = '128'
 
UPDATE fts
SET fts.DimTicketTypeId = 2
FROM     stg.FactTicketSales_V2  fts
        INNER JOIN dbo.DimItem_V2 di ON fts.DimItemId = di.DimItemId
        INNER JOIN dbo.DimPriceType_V2 dpt ON fts.DimPriceTypeId = dpt.DimPriceTypeId
WHERE  DimSeasonId = '228'
AND di.itemCode = '1A'
AND dpt.PriceTYpeCode = 'A'
 
 
 
 
 
 
--/*****************************************************************************************************************
--                                                          SEAT TYPE
--******************************************************************************************************************/
 
 
 
 
 
/*****************************************************************************************************************
                                                    FACT TAGS
******************************************************************************************************************/
 
--------IsComp TRUE--
 
UPDATE fts
SET fts.IsComp = 1
FROM stg.FactTicketSales_V2 fts 
        INNER JOIN dbo.DimPriceType_V2 dpt ON fts.DimPriceTypeId = dpt.DimPriceTypeId
WHERE  dpt.PriceTypeClass = 'COMP'
 
--------IsComp FALSE--
 
UPDATE fts
SET fts.IsComp = 0
FROM stg.FactTicketSales_V2 fts 
        INNER JOIN dbo.DimPriceType_V2 dpt ON fts.DimPriceTypeId = dpt.DimPriceTypeId
WHERE  dpt.PriceTypeClass <> 'COMP'
 
--------IsPlan TRUE--
 
UPDATE fts
SET fts.IsPlan = 1
, fts.IsPartial = 0
, fts.IsSingleEvent = 0
, fts.IsGroup = 0
FROM    stg.FactTicketSales_V2 fts 
        INNER JOIN dbo.DimPriceType_V2 dpt ON fts.DimPriceTypeId = dpt.DimPriceTypeId
 
WHERE 1=1
AND PriceTypeClass = 'SEA'
 
 
--------Is Partial Plan--
 
UPDATE fts
SET fts.IsPlan = 1
, fts.IsPartial = 1
, fts.IsSingleEvent = 0
, fts.IsGroup = 0
FROM     stg.FactTicketSales_V2 fts 
        INNER JOIN dbo.DimPriceType_V2 dpt ON fts.DimPriceTypeId = dpt.DimPriceTypeId
WHERE dpt.PriceTypeClass = 'PART'
 
 
 
--------Is Group--
 
UPDATE fts
SET fts.IsPlan = 0
, fts.IsPartial = 0
, fts.IsSingleEvent = 1
, fts.IsGroup = 1
FROM     stg.FactTicketSales_V2 fts 
        INNER JOIN dbo.DimPriceType_V2 dpt ON fts.DimPriceTypeId = dpt.DimPriceTypeId
WHERE  dpt.PriceTypeClass = 'GRP'
 
 
 
--------Is Single, not Group--
 
UPDATE fts
SET fts.IsPlan = 0
, fts.IsPartial = 0
, fts.IsSingleEvent = 1
, fts.IsGroup = 0
FROM     stg.FactTicketSales_V2 fts 
        INNER JOIN dbo.DimPriceType_V2 dpt ON fts.DimPriceTypeId = dpt.DimPriceTypeId
WHERE  dpt.PriceTypeClass IN ('SING', 'VIS')
 
 
 
--------is Premium TRUE--
 
------UPDATE f
------SET f.IsPremium = 1
------FROM #stgFactTicketSales   f
------INNER JOIN dbo.DimSeatType dst ON f.DimSeatTypeId = dst.DimSeatTypeId
------WHERE dst.DimSeatTypeId IN ('1', '2', '3', '4', '5')
 
--------is Premium FALSE--
 
------UPDATE f
------SET f.IsPremium = 0
------FROM #stgFactTicketSales  f
------INNER JOIN dbo.DimSeatType dst ON f.DimSeatTypeId = dst.DimSeatTypeId
------WHERE dst.SeatTypeCode IN ('-1', '6', '7', '8', '9', '10')
 
 
-------isBroker TRUE----
 
UPDATE f
SET f.IsBroker = 1
FROM stg.FactTicketSales_V2 f
INNER JOIN dbo.PD_PATRON p (NOLOCK) 
    ON f.ETL__SSID_PAC_CUSTOMER = p.PATRON
where p.VIP LIKE '%BR%'
 
 
 
 
----/*****************************************************************************************************************
----                                                            PLAN TYPE
----******************************************************************************************************************/
 
--------NEW----
 
UPDATE fts
SET fts.DimPlanTypeId = 1
FROM    stg.FactTicketSales_V2 fts 
        INNER JOIN dbo.DimPriceType_V2 dpt ON fts.DimPriceTypeId = dpt.DimPriceTypeId
 
WHERE 1=1
AND PriceTypeClass = 'SEA'
AND PriceTypeCode like 'N%'
 
 
----------ADD-ON----
 
UPDATE fts
SET fts.DimPlanTypeId = 2
FROM    stg.FactTicketSales_V2 fts 
        INNER JOIN dbo.DimPriceType_V2 dpt ON fts.DimPriceTypeId = dpt.DimPriceTypeId
 
WHERE 1=1
AND PriceTypeClass = 'SEA'
AND PriceTypeCode like 'T%'
 
 
---------- GENERAL RENEWAL----
 
UPDATE fts
SET fts.DimPlanTypeId = 3
FROM    stg.FactTicketSales_V2 fts 
        INNER JOIN dbo.DimPriceType_V2 dpt ON fts.DimPriceTypeId = dpt.DimPriceTypeId
 
WHERE 1=1
AND PriceTypeClass = 'SEA'
AND PriceTypeCode like 'R%'
AND PriceTypeCode NOT LIKE 'RL%'
 
---------- LOYALTY RENEWAL----
 
UPDATE fts
SET fts.DimPlanTypeId = 4
FROM    stg.FactTicketSales_V2 fts 
        INNER JOIN dbo.DimPriceType_V2 dpt ON fts.DimPriceTypeId = dpt.DimPriceTypeId
 
WHERE 1=1
AND PriceTypeClass = 'SEA'
AND PriceTypeCode LIKE 'RL%'
 
 
----------NO PLAN----
 
 
UPDATE fts
SET fts.DimPlanTypeId = 0
FROM    stg.FactTicketSales_V2 fts 
        INNER JOIN dbo.DimPriceType_V2 dpt ON fts.DimPriceTypeId = dpt.DimPriceTypeId
 
WHERE 1=1
AND PriceTypeClass <> 'SEA'
 
 
 
--------is Renewal TRUE--
 
UPDATE fts
SET fts.IsRenewal = 1
FROM    stg.FactTicketSales_V2 fts 
        INNER JOIN dbo.DimPriceType_V2 dpt ON fts.DimPriceTypeId = dpt.DimPriceTypeId
 
WHERE 1=1
AND PriceTypeClass = 'SEA'
AND PriceTypeCode LIKE 'R%'
 
 
 
--------is Renewal FALSE--
 
UPDATE fts
SET fts.IsRenewal = 0
FROM    stg.FactTicketSales_V2 fts 
        INNER JOIN dbo.DimPriceType_V2 dpt ON fts.DimPriceTypeId = dpt.DimPriceTypeId
 
WHERE 1=1
AND PriceTypeClass = 'SEA'
AND PriceTypeCode NOT LIKE 'R%'
 
END

GO
