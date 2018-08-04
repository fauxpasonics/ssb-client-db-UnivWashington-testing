SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO









/*****************************************************************************************************************
CHANGE LOG

2017/04/11 -- created by AMEITIN
2017/06/12 -- added some fact tags and renewal plan types
2017/07/23 -- archived TM version

Questions for client:



******************************************************************************************************************/



CREATE PROCEDURE [etl].[Cust_FactTicketSalesProcessing_Ticketmaster__AMEITIN_20170723]
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
FROM    #stgFactTicketSales fts 
        INNER JOIN dbo.DimItem di ON fts.DimItemId = di.DimItemId
		INNER JOIN dbo.DimPriceCode pc ON fts.DimPriceCodeId = pc.DimPriceCodeId
WHERE di.ItemCode like '%FS%'
AND pc.PriceCodeDesc NOT LIKE '%Dawg Pack%'


--------------PARTIALS--------------------------------

UPDATE fts
SET fts.DimTicketTypeId = 2
FROM [dbo].[FactTicketSales_V2_History] fts
  INNER JOIN dbo.DimItem_V2 di ON fts.DimItemId = di.DimItemId
		INNER JOIN dbo.DimSeason_V2 ds ON fts.DimSeasonId = ds.DimSeasonId
		INNER JOIN dbo.DimPriceCode_V2 pc ON fts.DimPriceCodeId = pc.DimPriceCodeId
WHERE 1=1
AND DimTicketTypeId = -1
AND di.ItemClass = 'Plan'
AND di.ItemDesc LIKE '%Plan%'
OR (pc.PriceCodeDesc LIKE '%Plan%')
OR (pc.PriceCodeDesc LIKE '%Pack%' AND PC1 <> 'S')


--If I need to exclude more try:

--AND ItemCode NOT LIKE '%FS'
--AND ItemCode NOT LIKE '%DEP'
--AND ItemCode NOT LIKE '%PRK'
--AND ItemCode NOT LIKE '%SC'
--AND ItemDesc NOT LIKE '%Passes%'
--AND ItemDesc NOT LIKE '%Parking%'
--AND ItemName NOT LIKE '%Student%'
--AND ItemName NOT LIKE '%Donations%'


--------------GROUP--------------------------------

UPDATE fts
SET fts.DimTicketTypeId = 3
FROM     [dbo].[FactTicketSales_V2_History] fts 
        INNER JOIN [dbo].[DimPriceCode_v2] pc ON fts.DimPriceCodeId = pc.DimPriceCodeId
WHERE pc.PriceCode LIKE '%G'
AND fts.DimPromoId > 0
AND PriceCode <> 'G' --removed this as I saw some that were named Donation and had no PriceCodeDesc. Client approved exclusion 4/13




--------------GROUP--------------------------------

UPDATE fts
SET fts.DimTicketTypeId = 4
FROM     [dbo].[FactTicketSales_V2_History] fts 
        INNER JOIN [dbo].[DimPriceCode_v2] pc ON fts.DimPriceCodeId = pc.DimPriceCodeId
WHERE pc.PriceCode LIKE '%G'
AND fts.DimPromoId <= 0
AND PriceCode <> 'G'



--------------SINGLE GAME-------------------------------

UPDATE fts
SET fts.DimTicketTypeId = 5
FROM [dbo].[FactTicketSales_V2_History] fts
  INNER JOIN dbo.DimItem_V2 di ON fts.DimItemId = di.DimItemId
		INNER JOIN dbo.DimSeason_V2 ds ON fts.DimSeasonId = ds.DimSeasonId
		INNER JOIN dbo.DimPriceCode_V2 pc ON fts.DimPriceCodeId = pc.DimPriceCodeId
WHERE di.ItemCode LIKE '%[0-9]'
--AND di.ItemClass = 'Event'
AND ds.SeasonName NOT LIKE '%Parking%'
AND ds.SeasonName NOT LIKE '%Misc%'
AND ds.SeasonName NOT LIKE '%Away%'
AND ds.SeasonName NOT LIKE '%Unknown%'
AND ds.SeasonName NOT LIKE '%scanning%'
AND ds.SeasonName NOT LIKE '%FCG%'
AND ds.SeasonName NOT LIKE '%Postseason%'
AND ds.SeasonName NOT LIKE '%Post Season%'
AND ds.SeasonName NOT LIKE '%Post-Season%'
AND fts.DimPromoId <= 0 --non-promotions
AND pc.PriceCode NOT LIKE '%V' --visiting tickets
AND pc.PriceCode NOT LIKE '%G' --group Tickets
AND ISNULL(pc.PriceCodeDesc, '') NOT LIKE '%Plan%' --partials
AND ISNULL(pc.PriceCodeDesc, '') NOT LIKE '%Pack%' --more partials



--------------SINGLE GAME PROMOTIONS-------------------------------

UPDATE fts
SET fts.DimTicketTypeId = 6
FROM [dbo].[FactTicketSales_V2_History] fts
  INNER JOIN dbo.DimItem_V2 di ON fts.DimItemId = di.DimItemId
		INNER JOIN dbo.DimSeason_V2 ds ON fts.DimSeasonId = ds.DimSeasonId
		INNER JOIN dbo.DimPriceCode_V2 pc ON fts.DimPriceCodeId = pc.DimPriceCodeId
WHERE di.ItemCode LIKE '%[0-9]'
--AND di.ItemClass = 'Event'
AND ds.SeasonName NOT LIKE '%Parking%'
AND ds.SeasonName NOT LIKE '%Misc%'
AND ds.SeasonName NOT LIKE '%Away%'
AND ds.SeasonName NOT LIKE '%Unknown%'
AND ds.SeasonName NOT LIKE '%scanning%'
AND ds.SeasonName NOT LIKE '%FCG%'
AND ds.SeasonName NOT LIKE '%Postseason%'
AND ds.SeasonName NOT LIKE '%Post Season%'
AND ds.SeasonName NOT LIKE '%Post-Season%'
AND fts.DimPromoId > 0 -- promotions
AND PriceCode NOT LIKE '%V' --visiting tickets
AND pc.PriceCode NOT LIKE '%G' --group Tickets
AND ISNULL(pc.PriceCodeDesc, '') NOT LIKE '%Plan%' --partials
AND ISNULL(pc.PriceCodeDesc, '') NOT LIKE '%Pack%' --more partials


--------------Visitor Tickets-------------------------------

UPDATE fts
SET fts.DimTicketTypeId = 7
FROM  [dbo].[FactTicketSales_V2_History]  fts 
        INNER JOIN dbo.DimItem_V2 di ON fts.DimItemId = di.DimItemId
		INNER JOIN dbo.DimSeason_V2 ds ON fts.DimSeasonId = ds.DimSeasonId
		INNER JOIN dbo.DimPriceCode_V2 pc ON fts.DimPriceCodeId = pc.DimPriceCodeId
WHERE di.ItemCode LIKE '%[0-9]'
--AND di.ItemClass = 'Event'
--AND ds.SeasonName NOT LIKE '%Parking%'
--AND ds.SeasonName NOT LIKE '%Misc%'
--AND ds.SeasonName NOT LIKE '%Away%'
--AND ds.SeasonName NOT LIKE '%Unknown%'
--AND ds.SeasonName NOT LIKE '%scanning%'
--AND ds.SeasonName NOT LIKE '%FCG%'
--AND ds.SeasonName NOT LIKE '%Postseason%'
--AND ds.SeasonName NOT LIKE '%Post Season%'
--AND ds.SeasonName NOT LIKE '%Post-Season%'
AND PriceCode LIKE '%V' --visiting tickets
AND (PriceCodeDesc LIKE '%Visitors' OR PriceCodeDesc LIKE 'Visiting%')

--------------Dawg Pack (aka Student Tickets)-------------------------------
UPDATE fts
SET fts.DimTicketTypeId = 8
FROM [dbo].[FactTicketSales_V2_History] fts 
		INNER JOIN dbo.DimEvent_V2 de ON fts.DimEventId = de.DimEventId
		INNER JOIN dbo.DimPriceCode_V2 pc ON fts.DimPriceCodeId = pc.DimPriceCodeId
WHERE 1=1
AND de.EventCode LIKE '%COM%'
OR pc.PriceCodeDesc LIKE '%Dawg Pack%'



--------------Parking-------------------------------
UPDATE fts
SET fts.DimTicketTypeId = 9
FROM    #stgFactTicketSales fts 
		INNER JOIN dbo.DimSeason ds ON fts.DimSeasonId = ds.DimSeasonId
WHERE 1=1
AND ds.SeasonName LIKE '%Park%'


--------------Seat Cushions-------------------------------
UPDATE fts
SET fts.DimTicketTypeId = 10
FROM    #stgFactTicketSales  fts
		INNER JOIN dbo.DimSeason ds ON fts.DimSeasonId = ds.DimSeasonId
		INNER JOIN dbo.DimItem di ON fts.DimItemId = di.DimItemId
WHERE 1=1
AND ds.SeasonName LIKE '%Football Misc%'
AND di.ItemName = 'Seat Cushions'


--------------Bus Passes-------------------------------
UPDATE fts
SET fts.DimTicketTypeId = 11
FROM    #stgFactTicketSales  fts
		INNER JOIN dbo.DimSeason ds ON fts.DimSeasonId = ds.DimSeasonId
		INNER JOIN dbo.DimItem di ON fts.DimItemId = di.DimItemId
WHERE 1=1
AND ds.SeasonName LIKE '%Football Misc%'
AND di.ItemName LIKE '%Bus Passes%'

--------------Seat Deposit-------------------------------
UPDATE fts
SET fts.DimTicketTypeId = 12
FROM    #stgFactTicketSales  fts
		INNER JOIN dbo.DimSeason ds ON fts.DimSeasonId = ds.DimSeasonId
		INNER JOIN dbo.DimPriceCode pc ON fts.DimPriceCodeId = pc.DimPriceCodeId
		INNER JOIN dbo.DimItem di ON fts.DimItemId = di.DimItemId
WHERE 1=1
AND ds.SeasonName LIKE '%Deposit%'
AND ISNULL(pc.PriceCodeDesc, '') NOT LIKE '%Group%'
OR di.ItemCode LIKE '%DEP'


--------------Group Deposit-------------------------------
UPDATE fts
SET fts.DimTicketTypeId = 13
FROM    #stgFactTicketSales  fts
		INNER JOIN dbo.DimSeason ds ON fts.DimSeasonId = ds.DimSeasonId
		INNER JOIN dbo.DimPriceCode pc ON fts.DimPriceCodeId = pc.DimPriceCodeId
WHERE 1=1
AND ds.SeasonName LIKE '%Deposit%' AND PriceCodeDesc LIKE '%Group%'

--------------PostSeason-------------------------------
UPDATE fts
SET fts.DimTicketTypeId = 14
FROM    #stgFactTicketSales  fts
		INNER JOIN dbo.DimSeason ds ON fts.DimSeasonId = ds.DimSeasonId
		INNER JOIN dbo.DimPriceCode pc ON fts.DimPriceCodeId = pc.DimPriceCodeId
		INNER JOIN dbo.DimItem di ON fts.DimItemId = di.DimItemId
WHERE 1=1
AND ds.SeasonName LIKE '%PostSeason%' 
OR ds.SeasonName LIKE '%Post Season%'
OR ds.SeasonName = '2016 Husky Football FCG'
OR ds.SeasonName = '2014-15 WBB Pac 12 Tournament'
OR ds.SeasonName = '2014-15 WBB NCAA'
OR ds.SeasonName = '2016 Husky Football Peach Bowl'
OR ds.SeasonName = '2017 Gymnastics Regionals'
OR di.ItemCode IN ('GY16S1S2', 'TF16S1S2', 'VB16R1R2')


--------------Ticket Package-------------------------------
--UPDATE fts
--SET fts.DimTicketTypeId = 15
--FROM    #stgFactTicketSales  fts
--		INNER JOIN dbo.DimSeason ds ON fts.DimSeasonId = ds.DimSeasonId
--		INNER JOIN dbo.DimPriceCode pc ON fts.DimPriceCodeId = pc.DimPriceCodeId
--WHERE 1=1
--AND ds.SeasonName LIKE '%PostSeason%' 


--------------Away Games-------------------------------
UPDATE fts
SET fts.DimTicketTypeId = 16
FROM    #stgFactTicketSales  fts
		INNER JOIN dbo.DimSeason ds ON fts.DimSeasonId = ds.DimSeasonId
		INNER JOIN dbo.DimPriceCode pc ON fts.DimPriceCodeId = pc.DimPriceCodeId
WHERE 1=1
AND ds.SeasonName LIKE '%Away Games%' 



--------------Miscellaneous-------------------------------
UPDATE fts
SET fts.DimTicketTypeId = 17
FROM    #stgFactTicketSales  fts
		INNER JOIN dbo.DimSeason ds ON fts.DimSeasonId = ds.DimSeasonId
		INNER JOIN dbo.DimItem di ON fts.DimItemId = di.DimItemId
WHERE 1=1
AND di.ItemName LIKE '%REPRINT%'


--------------BFE Contribution-------------------------------
UPDATE fts
SET fts.DimTicketTypeId = 20
FROM     #stgFactTicketSales  fts
INNER JOIN dbo.DimItem di on fts.dimitemId = di.DimitemId
INNER JOIN dbo.DimEvent de on fts.DimEventId = de.DimEventId
Where 1=1
AND EventName like '%BFE%'
AND ItemName like '%BFE%'

--/*****************************************************************************************************************
--															SEAT TYPE
--******************************************************************************************************************/





/*****************************************************************************************************************
													FACT TAGS
******************************************************************************************************************/

------IsComp TRUE--

UPDATE f
SET f.IsComp = 1
FROM #stgFactTicketSales  f
	JOIN dbo.DimPriceCode dpc
	ON dpc.DimPriceCodeId = f.DimPriceCodeId
WHERE dpc.PriceCode like '%C'

------IsComp FALSE--
UPDATE f
SET f.IsComp = 0
FROM #stgFactTicketSales  f
	JOIN dbo.DimPriceCode dpc
	ON dpc.DimPriceCodeId = f.DimPriceCodeId
WHERE dpc.PriceCode NOT like '%C'

------IsPlan TRUE--

UPDATE f
SET f.IsPlan = 1
, f.IsPartial = 0
, f.IsSingleEvent = 0
, f.IsGroup = 0
FROM #stgFactTicketSales  f
JOIN dbo.DimTicketType tt ON f.DimTicketTypeId = tt.DimTicketTypeId
WHERE tt.TicketTypeClass IN ('Season')


------Is Partial Plan--

UPDATE f
SET f.IsPlan = 1
, f.IsPartial = 1
, f.IsSingleEvent = 0
, f.IsGroup = 0
FROM #stgFactTicketSales  f
JOIN dbo.DimTicketType tt ON f.DimTicketTypeId = tt.DimTicketTypeId
WHERE tt.TicketTypeClass IN ('Partials')



------Is Group--

UPDATE f
SET f.IsPlan = 0
, f.IsPartial = 0
, f.IsSingleEvent = 1
, f.IsGroup = 1
FROM #stgFactTicketSales  f
WHERE DimTicketTypeId IN ('3', '4') 


------/*Group */

------Is Single, not Group--

UPDATE f
SET f.IsPlan = 0
, f.IsPartial = 0
, f.IsSingleEvent = 1
, f.IsGroup = 0
FROM #stgFactTicketSales  f
WHERE DimTicketTypeId IN ('5', '6', '7') 

------/*Single Game*/



------is Premium TRUE--

----UPDATE f
----SET f.IsPremium = 1
----FROM #stgFactTicketSales   f
----INNER JOIN dbo.DimSeatType dst ON f.DimSeatTypeId = dst.DimSeatTypeId
----WHERE dst.DimSeatTypeId IN ('1', '2', '3', '4', '5')

------is Premium FALSE--

----UPDATE f
----SET f.IsPremium = 0
----FROM #stgFactTicketSales  f
----INNER JOIN dbo.DimSeatType dst ON f.DimSeatTypeId = dst.DimSeatTypeId
----WHERE dst.SeatTypeCode IN ('-1', '6', '7', '8', '9', '10')


-----isBroker TRUE----

--UPDATE f
--SET f.IsBroker = 1
--FROM #stgFactTicketSales  f
--INNER JOIN dbo.DimCustomer dc ON dc.DimCustomerId = f.DimCustomerId AND dc.SourceSystem = 'TM'
--WHERE dc.AccountType = 'Broker  /E'




--/*****************************************************************************************************************
--															PLAN TYPE
--******************************************************************************************************************/

------NEW----

UPDATE fts
SET fts.DimPlanTypeId = 1
FROM    #stgFactTicketSales  fts
        INNER JOIN dbo.DimPriceCode pc ON pc.DimPriceCodeId = fts.DimPriceCodeId
WHERE 1=1
AND PriceCode LIKE '%N'
OR PriceCode LIKE '%1'


--------ADD-ON----

UPDATE fts
SET fts.DimPlanTypeId = 2
FROM    #stgFactTicketSales  fts
        INNER JOIN dbo.DimPriceCode pc ON pc.DimPriceCodeId = fts.DimPriceCodeId
WHERE 1=1
AND IsPlan = 1
AND ((fts.DimSeasonId IN ('97', '23', '49', '77') --Football Seasons 
AND (pc.PriceCode LIKE '%T' OR pc.PriceCode LIKE '%M'))
OR (fts.DimSeasonId IN ('9', '36', '61', '93') --Men's Basketball Seasons
AND (pc.PriceCode LIKE '%M' OR pc.PriceCode LIKE '%D'))
OR (fts.DimSeasonId IN ('6', '39', '66', '100') --Women's Basketball Seasons
AND pc.PriceCode LIKE '%D')
)


-------- GENERAL RENEWAL----

UPDATE fts
SET fts.DimPlanTypeId = 3
FROM    #stgFactTicketSales  fts
        INNER JOIN dbo.DimPriceCode pc ON pc.DimPriceCodeId = fts.DimPriceCodeId
WHERE   fts.IsPlan = 1
AND ((fts.DimSeasonId IN ('97', '23', '49', '77') --Football Seasons 
AND (pc.PC3 IN ('L', '2', '3', '4', '5')))
OR (fts.DimSeasonId IN ('9', '36', '61', '93') --Men's Basketball Seasons
AND (pc.PC3 IN ('L', '2', '3', '4', '5')))
OR (fts.DimSeasonId IN ('6', '39', '66', '100') --Women's Basketball Seasons
AND (pc.PriceCode LIKE '%R')))

-------- LOYALTY RENEWAL----

UPDATE fts
SET fts.DimPlanTypeId = 4
FROM    #stgFactTicketSales  fts
        INNER JOIN dbo.DimPriceCode pc ON pc.DimPriceCodeId = fts.DimPriceCodeId
WHERE   fts.IsPlan = 1
AND ((fts.DimSeasonId IN ('97', '23', '49', '77') --Football Seasons 
AND (pc.PriceCode LIKE '%R'))
OR (fts.DimSeasonId IN ('9', '36', '61', '93') --Men's Basketball Seasons
AND (pc.PriceCode LIKE '%R')))


--------NO PLAN----


UPDATE fts
SET fts.DimPlanTypeId = 0
FROM    #stgFactTicketSales  fts
WHERE   IsPlan = 0



------is Renewal TRUE--

UPDATE f
SET f.IsRenewal = 1
FROM #stgFactTicketSales  f
INNER JOIN dbo.DimPlanType dpt ON f.DimPlanTypeId = dpt.DimPlanTypeId
WHERE dpt.PlanTypeDesc IN ('Renewed Plan')



------is Renewal FALSE--

UPDATE f
SET f.IsRenewal = 0
FROM #stgFactTicketSales  f
INNER JOIN dbo.DimPlanType dpt ON f.DimPlanTypeId = dpt.DimPlanTypeId
WHERE dpt.PlanTypeDesc NOT IN ('Renewed Plan')



END 





























GO
