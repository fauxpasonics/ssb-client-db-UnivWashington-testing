SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


 
 
 
 
 
 
 
-- =============================================
-- Created By: Abbey Meitin
-- Create Date: 2017/08/28
-- Reviewed By: Payton Soicher
-- Reviewed Date: 2017/07/12
-- Description: FactTicketSales BusinessRules
-- =============================================
  
/***** Revision History
  
Abbey Meitin: 2018-06-08: Added Temporary Season Ticket item logic

Payton Soicher: 2018-07-12:  Changed full season not to look at ItemCode 'HP'; reviewed by Ameitin 2017-07-15
				
 
*****/
 
CREATE PROCEDURE [etl].[Cust_FactOdetProcessing]
( 
    @BatchId NVARCHAR(50) = '00000000-0000-0000-0000-000000000000', 
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
FROM     stg.PAC_FactOdet fts 
        INNER JOIN dbo.DimPriceType_V2 dpt (NOLOCK) 
			ON fts.DimPriceTypeId = dpt.DimPriceTypeId
		INNER JOIN dbo.DimItem_V2 di (NOLOCK)
			ON di.DimItemId = fts.DimItemId
WHERE dpt.PriceTypeClass = 'SEA'
AND di.ItemCode <> 'HP'
 
--------------TEMPORARY SEASON TICKETS ----- added 2018-076-08 by Ameitin
 
UPDATE fts
SET fts.DimTicketTypeId = 27
FROM     stg.PAC_FactOdet fts 
        INNER JOIN dbo.DimItem_V2 di (NOLOCK) 
            ON fts.DimItemId = di.DimItemId
WHERE di.ItemCode IN ('FSVB', 'FSMB', 'FSWB', 'FSSB', 'FSBS', 'FSMS','FSWS')
 
 
--------------PARTIALS--------------------------------
 
UPDATE fts
SET fts.DimTicketTypeId = 2
 
FROM     stg.PAC_FactOdet fts 
        INNER JOIN dbo.DimPriceType_V2 dpt (NOLOCK)
			ON fts.DimPriceTypeId = dpt.DimPriceTypeId
WHERE dpt.PriceTypeClass = 'PART'
 
 
 
--------------GROUP--------------------------------
 
UPDATE fts
SET fts.DimTicketTypeId = 3
 
FROM     stg.PAC_FactOdet fts 
        INNER JOIN dbo.DimPriceType_V2 dpt ON fts.DimPriceTypeId = dpt.DimPriceTypeId
WHERE  dpt.PriceTypeClass = 'GRP'
AND fts.DimPromoId = 0
 
 
--------------GROUP PROMO--------------------------------
 
UPDATE fts
SET fts.DimTicketTypeId = 4
 
FROM     stg.PAC_FactOdet fts 
        INNER JOIN dbo.DimPriceType_V2 dpt ON fts.DimPriceTypeId = dpt.DimPriceTypeId
WHERE  dpt.PriceTypeClass = 'GRP'
AND fts.DimPromoId <> 0
 
 
 
--------------SINGLE GAME-------------------------------
 
UPDATE fts
SET fts.DimTicketTypeId = 5
FROM     stg.PAC_FactOdet fts 
        INNER JOIN dbo.DimPriceType_V2 dpt ON fts.DimPriceTypeId = dpt.DimPriceTypeId
        INNER JOIN dbo.Dimevent_V2 de ON fts.DimEventId = de.DimEventId
WHERE  dpt.PriceTypeClass = 'SING'
AND de.PAC_EGROUP = 'H'
AND fts.DimPromoId <= 0
 
 
 
--------------SINGLE GAME PROMOTIONS-------------------------------
 
 
UPDATE fts
SET fts.DimTicketTypeId = 6
FROM     stg.PAC_FactOdet fts 
        INNER JOIN dbo.DimPriceType_V2 dpt ON fts.DimPriceTypeId = dpt.DimPriceTypeId
        INNER JOIN dbo.Dimevent_V2 de ON fts.DimEventId = de.DimEventId
WHERE  dpt.PriceTypeClass = 'SING'
AND de.PAC_EGROUP = 'H'
AND fts.DimPromoId > 0
 
 
--------------Visitor Tickets-------------------------------
 
UPDATE fts
SET fts.DimTicketTypeId = 7
 
FROM     stg.PAC_FactOdet fts 
        INNER JOIN dbo.DimPriceType_V2 dpt ON fts.DimPriceTypeId = dpt.DimPriceTypeId
WHERE  dpt.PriceTypeClass = 'VIS'
 
--------------StubHub Direct Lists------------------------------
 
UPDATE fts
SET fts.DimTicketTypeId = 26
 
FROM     stg.PAC_FactOdet fts 
        INNER JOIN dbo.DimPriceType_V2 dpt ON fts.DimPriceTypeId = dpt.DimPriceTypeId
WHERE  dpt.PriceTypeClass = 'SHDI'
 
 
--------------Dawg Pack (aka Student Tickets)-------------------------------
UPDATE fts
SET fts.DimTicketTypeId = 8
 
FROM     stg.PAC_FactOdet fts 
        INNER JOIN dbo.DimPriceType_V2 dpt ON fts.DimPriceTypeId = dpt.DimPriceTypeId
        INNER JOIN dbo.DimPlan_V2 dpl on fts.DimPlanId = dpl.DimPlanId
WHERE  dpt.PriceTypeClass = 'DP'
AND dpl.PlanCode = 'DP'

--  ==================================================================
--  7/12/2018 11:21 AM
--  Payton Soicher
--  Subject: Husky Pass Addition
--  ==================================================================

--------------Husky Pass-------------------------------
UPDATE fts 
SET fts.DimTicketTypeId = (SELECT DimTicketTypeId FROM dbo.DimTicketType_V2 WHERE TicketTypeCode = 'HP')
FROM stg.PAC_FactOdet fts
	INNER JOIN dbo.DimItem_V2 di (NOLOCK)
		ON di.DimItemId = fts.DimItemId
WHERE di.ItemCode = 'HP'

 
--------------COMPS-------------------------------
UPDATE fts
SET fts.DimTicketTypeId = 24
FROM     stg.PAC_FactOdet fts 
        INNER JOIN dbo.DimPriceType_V2 dpt ON fts.DimPriceTypeId = dpt.DimPriceTypeId
WHERE  dpt.PriceTypeClass = 'COMP'
 
 
--------------Parking-------------------------------
UPDATE fts
SET fts.DimTicketTypeId = 9
 
FROM       stg.PAC_FactOdet fts
INNER JOIN dbo.DimEvent_V2 de on fts.DimEventId = de.DimEventId
INNER JOIN dbo.DimSeason_V2 ds on fts.DimSeasonId = ds.DimSeasonId
--INNER JOIN dbo.DimItem_V2 di on fts.DimItemId = di.DimItemId
Where 1=1
AND PAC_EGROUP = 'P'
AND ds.SeasonCode NOT LIKE 'VB%'
 
 
--------------Seat Cushions-------------------------------
UPDATE fts
SET fts.DimTicketTypeId = 10
 
FROM     stg.PAC_FactOdet  fts
INNER JOIN dbo.DimEvent_V2 de on fts.DimEventId = de.DimEventId
Where 1=1
AND PAC_EGROUP = 'SC'
 
 
--------------Bus Passes-------------------------------
UPDATE fts
SET fts.DimTicketTypeId = 11
 
FROM     stg.PAC_FactOdet  fts
INNER JOIN dbo.DimEvent_V2 de on fts.DimEventId = de.DimEventId
Where 1=1
AND PAC_EGROUP = 'TB'
 
--------------Seat Deposit-------------------------------
UPDATE fts
SET fts.DimTicketTypeId = 12
 
FROM    stg.PAC_FactOdet  fts
        INNER JOIN dbo.DimItem_V2 di ON fts.DimItemId = di.DimItemId
WHERE 1=1
AND di.ItemClass = 'FSDEP'
 
 
 
--------------Group Deposit-------------------------------
UPDATE fts
SET fts.DimTicketTypeId = 13
 
FROM    stg.PAC_FactOdet  fts
        INNER JOIN dbo.DimItem_V2 di ON fts.DimItemId = di.DimItemId
WHERE 1=1
AND di.ItemClass = 'GPDEP'
 
 
--------------Partial Deposit-------------------------------
UPDATE fts
SET fts.DimTicketTypeId = 23
 
FROM    stg.PAC_FactOdet  fts
        INNER JOIN dbo.DimItem_V2 di ON fts.DimItemId = di.DimItemId
WHERE 1=1
AND di.ItemClass = 'PPDEP'
 
 
--------------PostSeason-------------------------------
UPDATE fts
SET fts.DimTicketTypeId = 14
 
FROM    stg.PAC_FactOdet  fts
INNER JOIN dbo.DimEvent_V2 de on fts.DimEventId = de.DimEventId
INNER JOIN dbo.DimSeason_V2 ds on fts.DimSeasonId = ds.DimSeasonId
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
 
FROM     stg.PAC_FactOdet  fts
INNER JOIN dbo.DimEvent_V2 de on fts.DimEventId = de.DimEventId
Where 1=1
AND PAC_EGROUP = 'A'
 
 
 
--------------Miscellaneous-------------------------------
UPDATE fts
SET fts.DimTicketTypeId = 17
 
FROM    stg.PAC_FactOdet  fts
        INNER JOIN dbo.DimItem_V2 di ON fts.DimItemId = di.DimItemId
WHERE 1=1
AND di.PAC_BASIS = 'M'
AND ItemClass NOT LIKE '%DEP'
 
 
--------------BFE Contribution-------------------------------
UPDATE fts
SET fts.DimTicketTypeId = 20
 
FROM     stg.PAC_FactOdet  fts
INNER JOIN dbo.DimEvent_V2 de on fts.DimEventId = de.DimEventId
Where 1=1
AND PAC_EGROUP = 'BFE'
 
--------------Zone Pass-------------------------------
UPDATE fts
SET fts.DimTicketTypeId = 25
FROM     stg.PAC_FactOdet  fts
INNER JOIN dbo.DimEvent_V2 de on fts.DimEventId = de.DimEventId
Where 1=1
AND PAC_EGROUP = 'ZP'
 
--------------Dawg Pack Singles  (aka Student Tickets)-------------------------------
UPDATE fts
SET fts.DimTicketTypeId = 22
FROM     stg.PAC_FactOdet  fts
        INNER JOIN dbo.DimPriceType_V2 dpt ON fts.DimPriceTypeId = dpt.DimPriceTypeId
        INNER JOIN dbo.DimItem_V2 di on fts.DimItemId = di.DimItemId
WHERE  dpt.PriceTypeClass = 'DP'
AND di.PAC_BASIS = 'S'
 
UPDATE fts
SET fts.DimTicketTypeId = 22
FROM     stg.PAC_FactOdet  fts
        INNER JOIN dbo.DimPriceType_V2 dpt ON fts.DimPriceTypeId = dpt.DimPriceTypeId
        INNER JOIN dbo.DimItem_V2 di on fts.DimItemId = di.DimItemId
WHERE  di.PAC_BASIS = 'S'
AND dpt.PriceTypeCode = 'CDP'
 
--------------Gold Card-------------------------------
 
UPDATE fts
SET fts.DimTicketTypeId = 19
FROM      stg.PAC_FactOdet  fts (NOLOCK)
INNER JOIN dbo.DimItem_V2 di (NOLOCK)
    on fts.DimItemId = di.DimItemId
Where 1=1
AND ItemCode = 'HGC'
 
 
 
 
 
 
 
--/*****************************************************************************************************************
--                                                          SEAT TYPE
--******************************************************************************************************************/
 
UPDATE fo
SET fo.DimSeatTypeId = dst.DimSeatTypeId 
 
FROM stg.PAC_FactOdet fo
INNER JOIN [etl].[vw_DimSeat] ds ON fo.DimseatId_Start = ds.DimSeatId
INNER JOIN [dbo].[DimSeatType_AlaskaAirlinesArenaSeat_20171127] dstaa 
INNER JOIN etl.vw_DimSeatType dst on dstaa.SectionTyeeName = dst.SeatTypeName
    ON ds.ETL__SSID_PAC_LEVEL = dstaa.[Level] COLLATE SQL_Latin1_General_CP1_CI_AS
    AND ds.ETL__SSID_PAC_SECTION = dstaa.[Section] COLLATE SQL_Latin1_General_CP1_CI_AS
    AND ds.ETL__SSID_PAC_ROW = dstaa.[Row] COLLATE SQL_Latin1_General_CP1_CI_AS
    AND ds.ETL__SSID_PAC_SEAT = dstaa.[Seat] COLLATE SQL_Latin1_General_CP1_CI_AS
WHERE ds.ETL__SourceSystem = 'PAC'
AND ds.ETL__SSID_PAC_SEASON like 'MB%'
 
 
/*****************************************************************************************************************
                                                    FACT TAGS
******************************************************************************************************************/
 
--------IsComp TRUE--
 
UPDATE fts
SET fts.IsComp = 1
 
FROM stg.PAC_FactOdet fts 
        INNER JOIN dbo.DimPriceType_V2 dpt ON fts.DimPriceTypeId = dpt.DimPriceTypeId
WHERE  dpt.PriceTypeClass = 'COMP'
 
--------IsComp FALSE--
 
UPDATE fts
SET fts.IsComp = 0
 
FROM stg.PAC_FactOdet fts 
        INNER JOIN dbo.DimPriceType_V2 dpt ON fts.DimPriceTypeId = dpt.DimPriceTypeId
WHERE  dpt.PriceTypeClass <> 'COMP'
 
--------IsPlan TRUE--
 
UPDATE fts
SET fts.IsPlan = 1
, fts.IsPartial = 0
, fts.IsSingleEvent = 0
, fts.IsGroup = 0
 
FROM    stg.PAC_FactOdet fts 
        INNER JOIN dbo.DimPriceType_V2 dpt ON fts.DimPriceTypeId = dpt.DimPriceTypeId
 
WHERE 1=1
AND PriceTypeClass = 'SEA'
 
 
--------Is Partial Plan--
 
UPDATE fts
SET fts.IsPlan = 1
, fts.IsPartial = 1
, fts.IsSingleEvent = 0
, fts.IsGroup = 0
 
FROM     stg.PAC_FactOdet fts 
        INNER JOIN dbo.DimPriceType_V2 dpt ON fts.DimPriceTypeId = dpt.DimPriceTypeId
WHERE dpt.PriceTypeClass = 'PART'
 
 
 
--------Is Group--
 
UPDATE fts
SET fts.IsPlan = 0
, fts.IsPartial = 0
, fts.IsSingleEvent = 1
, fts.IsGroup = 1
 
FROM     stg.PAC_FactOdet fts 
        INNER JOIN dbo.DimPriceType_V2 dpt ON fts.DimPriceTypeId = dpt.DimPriceTypeId
WHERE  dpt.PriceTypeClass = 'GRP'
 
 
 
--------Is Single, not Group--
 
UPDATE fts
SET fts.IsPlan = 0
, fts.IsPartial = 0
, fts.IsSingleEvent = 1
, fts.IsGroup = 0
 
FROM     stg.PAC_FactOdet fts 
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
 
----UPDATE f
----SET f.IsBroker = 1
----FROM #stgFactTicketSales  f
----INNER JOIN dbo.DimCustomer dc ON dc.DimCustomerId = f.DimCustomerId AND dc.SourceSystem = 'TM'
----WHERE dc.AccountType = 'Broker  /E'
 
 
 
 
----/*****************************************************************************************************************
----                                                            PLAN TYPE
----******************************************************************************************************************/
 
--------NEW----
 
UPDATE fts
SET fts.DimPlanTypeId = 1
 
FROM    stg.PAC_FactOdet fts 
        INNER JOIN dbo.DimPriceType_V2 dpt ON fts.DimPriceTypeId = dpt.DimPriceTypeId
 
WHERE 1=1
AND PriceTypeClass = 'SEA'
AND PriceTypeCode like 'N%'
 
 
----------ADD-ON----
 
UPDATE fts
SET fts.DimPlanTypeId = 2
 
FROM    stg.PAC_FactOdet fts 
        INNER JOIN dbo.DimPriceType_V2 dpt ON fts.DimPriceTypeId = dpt.DimPriceTypeId
 
WHERE 1=1
AND PriceTypeClass = 'SEA'
AND PriceTypeCode like 'T%'
 
 
---------- GENERAL RENEWAL----
 
UPDATE fts
SET fts.DimPlanTypeId = 3
 
FROM    stg.PAC_FactOdet fts 
        INNER JOIN dbo.DimPriceType_V2 dpt ON fts.DimPriceTypeId = dpt.DimPriceTypeId
 
WHERE 1=1
AND PriceTypeClass = 'SEA'
AND PriceTypeCode like 'R%'
AND PriceTypeCode NOT LIKE 'RL%'
 
---------- LOYALTY RENEWAL----
 
UPDATE fts
SET fts.DimPlanTypeId = 4
 
FROM    stg.PAC_FactOdet fts 
        INNER JOIN dbo.DimPriceType_V2 dpt ON fts.DimPriceTypeId = dpt.DimPriceTypeId
 
WHERE 1=1
AND PriceTypeClass = 'SEA'
AND PriceTypeCode LIKE 'RL%'
 
 
----------NO PLAN----
 
 
UPDATE fts
SET fts.DimPlanTypeId = 0
 
FROM    stg.PAC_FactOdet fts 
        INNER JOIN dbo.DimPriceType_V2 dpt ON fts.DimPriceTypeId = dpt.DimPriceTypeId
 
WHERE 1=1
AND PriceTypeClass <> 'SEA'
 
 
 
--------is Renewal TRUE--
 
UPDATE fts
SET fts.IsRenewal = 1
 
FROM    stg.PAC_FactOdet fts 
        INNER JOIN dbo.DimPriceType_V2 dpt ON fts.DimPriceTypeId = dpt.DimPriceTypeId
 
WHERE 1=1
AND PriceTypeClass = 'SEA'
AND PriceTypeCode LIKE 'R%'
 
 
 
--------is Renewal FALSE--
 
UPDATE fts
SET fts.IsRenewal = 0
 
FROM    stg.PAC_FactOdet fts 
        INNER JOIN dbo.DimPriceType_V2 dpt ON fts.DimPriceTypeId = dpt.DimPriceTypeId
 
WHERE 1=1
AND PriceTypeClass = 'SEA'
AND PriceTypeCode NOT LIKE 'R%'
 
-----is Broker True--
 
UPDATE f
SET f.IsBroker = 1
FROM stg.PAC_FactOdet f
INNER JOIN dbo.PD_PATRON p (NOLOCK) 
    ON f.ETL__SSID_PAC_CUSTOMER = p.PATRON
WHERE p.VIP LIKE '%BR%'
 
 
 
END
 
 
 
 
 
 
GO
