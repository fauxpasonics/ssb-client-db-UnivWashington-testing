SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [etl].[PAC_Stage_FactTicketActivity] 
( 
	@BatchId UNIQUEIDENTIFIER = '00000000-0000-0000-0000-000000000000', 
	@Options NVARCHAR(max) = NULL 
) 
 
AS 
BEGIN 



--DROP TABLE #DataSet

SELECT *
, CAST(dbo.fnGetValueFromDelimitedString(MP_SBLS,':',1) AS NVARCHAR(50)) COLLATE SQL_Latin1_General_CP1_CS_AS [LEVEL]
, CAST(dbo.fnGetValueFromDelimitedString(MP_SBLS,':',2) AS NVARCHAR(50)) COLLATE SQL_Latin1_General_CP1_CS_AS [SECTION]
, CAST(dbo.fnGetValueFromDelimitedString(MP_SBLS,':',3) AS NVARCHAR(50)) COLLATE SQL_Latin1_General_CP1_CS_AS [ROW]
, CAST(dbo.fnGetValueFromDelimitedString(dbo.fnGetValueFromDelimitedString(MP_SBLS,':',4),',','1') AS NVARCHAR(25)) COLLATE SQL_Latin1_General_CP1_CS_AS FIRST_SEAT
, CAST(dbo.fnGetValueFromDelimitedString(dbo.fnGetValueFromDelimitedString(MP_SBLS,':',4),',','2') AS NVARCHAR(25)) COLLATE SQL_Latin1_General_CP1_CS_AS LAST_SEAT
INTO #DataSet
FROM dbo.TK_TRANS_MP
WHERE 1=1
AND SALECODE = 'SH'
AND MP_SELLER IS NOT NULL


CREATE NONCLUSTERED INDEX IX_SEASON ON #DataSet (SEASON)
CREATE NONCLUSTERED INDEX IX_MP_EVENT ON #DataSet (MP_EVENT)
CREATE NONCLUSTERED INDEX IX_MP_SELLER ON #DataSet (MP_SELLER)
CREATE NONCLUSTERED INDEX IX_MP_BUYER ON #DataSet (MP_BUYER)
CREATE NONCLUSTERED INDEX IX_Seat ON #DataSet ([LEVEL], [SECTION], [ROW], FIRST_SEAT)


DECLARE @DimActivityId INT

SELECT TOP 1 @DimActivityId = DimActivityId
FROM etl.vw_DimActivity
WHERE ETL__SourceSystem = 'PAC' AND ETL__SSID = 'CI Default: StubHub'

TRUNCATE TABLE stg.PAC_FactTicketActivity 

INSERT INTO stg.PAC_FactTicketActivity 
(
    ETL__SSID, ETL__SSID_PAC_SEASON, ETL__SSID_PAC_TRANS_NO, DimDateId, DimTimeId, DimArenaId, DimSeasonId, DimItemId, DimEventId,
    DimPlanId, DimSeatId_Start, DimTicketCustomerId, DimTicketCustomerId_Recipient, DimActivityId, TransDateTime, QtySeat,
    SubTotal, Fees, Taxes, Total, UpdatedBy, UpdatedDate, PAC_MP_BOCHG, PAC_MP_BUY_AMT, PAC_MP_BUY_NET, PAC_MP_BUYER,
    PAC_MP_DIFF, PAC_MP_DMETH_TYPE, PAC_MP_NETITEM, PAC_MP_OWNER, PAC_MP_SELLCR, PAC_MP_SELLER, PAC_MP_SELLTIXAMT,
    PAC_MP_SHPAID, PAC_MP_SOCHG, PAC_MP_TIXAMT, PAC_MP_PL
)

SELECT 
	CONCAT(ds.SEASON, ':', ds.TRANS_NO) ETL__SSID
	, ds.SEASON ETL__SSID_PAC_SEASON
	, ds.TRANS_NO ETL__SSID_PAC_TRANS_NO

	, CONVERT(NVARCHAR(8), ds.LAST_DATETIME, 112) DimDateId 
	, CASE WHEN ds.LAST_DATETIME IS NULL THEN 0 ELSE datediff(second, cast(ds.LAST_DATETIME as date), ds.LAST_DATETIME) END DimTimeId 
	
	
	, isnull(dArena.DimArenaId, -1) DimArenaId
	, isnull(dSeason.DimSeasonId, -1) DimSeasonId
	, isnull(dItem.DimItemId, -1) DimItemId
	, isnull(dEvent.DimEventId, -1) DimEventId
	, CASE WHEN ISNULL(dItem.ItemType,'') <> 'Plan' THEN 0 ELSE isnull(dPlan.DimPlanId, -1) END DimPlanId		
	
	, isnull(dSeat.DimSeatId, -1) DimSeatId_Start
	, isnull(dTicketCustomer.DimTicketCustomerId, -1) DimTicketCustomerId
	, isnull(dTicketCustomerRecipient.DimTicketCustomerId, -1) DimTicketCustomerId_Recipient
	, isnull(@DimActivityId, -1) DimActivityId
	, ds.LAST_DATETIME TransDateTime
	, ds.MP_QTY QtySeat
	, ds.MP_SELLCR SubTotal
	, (ds.MP_BUY_AMT - ds.MP_SELLCR) Fees
	, 0 Taxes
	, ds.MP_BUY_AMT Total
	, ds.LAST_USER UpdatedBy	
	, ds.LAST_DATETIME UpdatedDate

	, ds.MP_BOCHG
	, ds.MP_BUY_AMT
	, ds.MP_BUY_NET
	, ds.MP_BUYER
	, ds.MP_DIFF
	, ds.MP_DMETH_TYPE
	, ds.MP_NETITEM
	, ds.MP_OWNER
	, ds.MP_SELLCR
	, ds.MP_SELLER
	, ds.MP_SELLTIXAMT
	, ds.MP_SHPAID
	, ds.MP_SOCHG
	, ds.MP_TIXAMT
	, ds.MP_PL

--SELECT COUNT(*)
FROM #DataSet ds

LEFT OUTER JOIN etl.vw_DimItem (nolock) dItem ON ds.SEASON = dItem.ETL__SSID_PAC_SEASON AND ds.MP_EVENT = dItem.ETL__SSID_PAC_ITEM
	AND dItem.ETL__SourceSystem = 'PAC' AND dItem.DimItemId > 0 AND dItem.ETL__IsDeleted = 0

LEFT OUTER JOIN etl.vw_DimEvent (nolock) dEvent ON ds.SEASON = dEvent.ETL__SSID_PAC_SEASON AND ds.MP_EVENT = dEvent.ETL__SSID_PAC_EVENT
	AND dEvent.ETL__SourceSystem = 'PAC' AND dEvent.DimEventId > 0 AND dEvent.ETL__IsDeleted = 0

LEFT OUTER JOIN etl.vw_DimPlan (nolock) dPlan ON ds.SEASON = dPlan.ETL__SSID_PAC_SEASON AND ds.MP_EVENT = dPlan.ETL__SSID_PAC_ITEM
	AND dPlan.ETL__SourceSystem = 'PAC' AND dPlan.DimPlanId > 0 AND dPlan.ETL__IsDeleted = 0

LEFT OUTER JOIN etl.vw_DimSeason (nolock) dSeason ON ds.SEASON = dSeason.ETL__SSID_PAC_SEASON
	AND dSeason.ETL__SourceSystem = 'PAC' AND dSeason.DimSeasonId > 0 AND dSeason.ETL__IsDeleted = 0

LEFT OUTER JOIN etl.vw_DimArena (nolock) dArena ON dEvent.Arena COLLATE SQL_Latin1_General_CP1_CS_AS = dArena.ETL__SSID_PAC_FACILITY
	AND dArena.ETL__SourceSystem = 'PAC' AND dArena.DimArenaId > 0 AND dArena.ETL__IsDeleted = 0

LEFT OUTER JOIN etl.vw_DimTicketCustomer (NOLOCK) dTicketCustomer ON ds.MP_SELLER = dTicketCustomer.ETL__SSID_PAC_PATRON
	AND dTicketCustomer.ETL__SourceSystem = 'PAC' AND dTicketCustomer.DimTicketCustomerId > 0 AND dTicketCustomer.ETL__IsDeleted = 0

LEFT OUTER JOIN etl.vw_DimTicketCustomer (NOLOCK) dTicketCustomerRecipient ON ds.MP_BUYER = dTicketCustomerRecipient.ETL__SSID_PAC_PATRON
	AND dTicketCustomerRecipient.ETL__SourceSystem = 'PAC' AND dTicketCustomerRecipient.DimTicketCustomerId > 0 AND dTicketCustomerRecipient.ETL__IsDeleted = 0

LEFT OUTER JOIN etl.vw_DimSeat (nolock) dSeat ON ds.SEASON = dSeat.ETL__SSID_PAC_SEASON AND ds.[LEVEL] = dseat.ETL__SSID_PAC_LEVEL AND ds.SECTION = dseat.ETL__SSID_PAC_SECTION AND ds.[ROW] = dseat.ETL__SSID_PAC_ROW AND ds.FIRST_SEAT = dseat.ETL__SSID_PAC_SEAT
	AND dSeat.ETL__SourceSystem = 'PAC' AND dSeat.DimSeatId > 0 AND dSeat.ETL__IsDeleted = 0



END
GO
