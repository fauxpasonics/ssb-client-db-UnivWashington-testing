SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE PROCEDURE [etl].[PAC_Stage_FactAvailSeats] 
( 
	@BatchId UNIQUEIDENTIFIER = '00000000-0000-0000-0000-000000000000', 
	@Options NVARCHAR(max) = NULL 
) 
 
AS 
BEGIN 
 

DECLARE @OptionsXML XML = TRY_CAST(@Options AS XML)


DECLARE @LoadDate DATETIME = (GETDATE() - 2000)

SELECT @LoadDate = t.x.value('LoadDate[1]','DateTime')
FROM @OptionsXML.nodes('options') t(x)

PRINT @LoadDate

--DROP TABLE #DataSet
SELECT *
INTO #DataSet
FROM dbo.TK_SEAT_SEAT
WHERE CUSTOMER IS NULL
AND SEAT IS NOT NULL
AND EXPORT_DATETIME >= @LoadDate
--AND SEASON = 'FB17' 
--AND EVENT = 'FB01'



CREATE NONCLUSTERED INDEX IX_SEASON ON #DataSet (SEASON)
CREATE NONCLUSTERED INDEX IX_EVENT ON #DataSet ([EVENT])
CREATE NONCLUSTERED INDEX IX_SECTION ON #DataSet (SECTION)
CREATE NONCLUSTERED INDEX IX_ROW ON #DataSet ([ROW])
CREATE NONCLUSTERED INDEX IX_SEAT ON #DataSet (SEAT)
CREATE NONCLUSTERED INDEX IX_STAT ON #DataSet (STAT)
CREATE NONCLUSTERED INDEX IX_PL ON #DataSet (PL)



TRUNCATE TABLE stg.PAC_FactAvailSeats

INSERT INTO stg.PAC_FactAvailSeats 
(
    ETL__SSID, ETL__SSID_PAC_SEASON, ETL__SSID_PAC_EVENT, ETL__SSID_PAC_LEVEL, ETL__SSID_PAC_SECTION, ETL__SSID_PAC_ROW, ETL__SSID_PAC_SEAT,
    DimDateId, DimTimeId, DimArenaId, DimSeasonId, DimItemId, DimEventId, DimPlanId, DimPriceLevelId, DimPriceTypeId, DimPriceCodeId,
    DimSeatId_Start, DimSeatStatusId, DimPlanTypeId, DimTicketTypeId, DimSeatTypeId, DimTicketClassId,
    PostedDateTime, QtySeat, SubTotal, Fees, Taxes, Total
)



SELECT 
	CONCAT(ds.SEASON, ':', ds.[EVENT], ':', ds.LEVEL, ':', ds.SECTION, ':', ds.[ROW], ':', ds.SEAT) ETL__SSID
	, ds.SEASON ETL__SSID_PAC_SEASON
	, ds.EVENT ETL__SSID_PAC_EVENT
	, ds.LEVEL ETL__SSID_PAC_LEVEL
	, ds.SECTION ETL__SSID_PAC_SECTION
	, ds.ROW ETL__SSID_PAC_ROW
	, ds.SEAT ETL__SSID_PAC_SEAT

	, CONVERT(VARCHAR, ds.EXPORT_DATETIME, 112) DimDateId
	, datediff(second, cast(ds.EXPORT_DATETIME as date), ds.EXPORT_DATETIME) DimTimeId
	
	, isnull(dArena.DimArenaId, -1) DimArenaId
	, isnull(dSeason.DimSeasonId, -1) DimSeasonId
	, isnull(dItem.DimItemId, -1) DimItemId
	, isnull(dEvent.DimEventId, -1) DimEventId
	, CASE WHEN ISNULL(dItem.ItemType,'') <> 'Plan' THEN 0 ELSE isnull(dPlan.DimPlanId, -1) END DimPlanId	
	, ISNULL(dPriceLevel.DimPriceLevelId, -1) DimPriceLevelId
	, 0 DimPriceTypeId
	, 0 DimPriceCodeId
	, isnull(dSeat.DimSeatId, -1) DimSeatId_Start
	, isnull(dSeatStatus.DimSeatStatusId, -1) DimSeatStatusId	

	, -1 DimPlanTypeId
	, -1 DimTicketTypeId
	, -1 DimSeatTypeId
	, -1 DimTicketClassId
	
	, ds.EXPORT_DATETIME [PostedDateTime]

	, 1 QtySeat

	, NULL [SubTotal]
	, NULL [Fees]
	, NULL [Taxes]
	, NULL [Total]
		
--35546

--SELECT COUNT(*)
FROM #DataSet ds


LEFT OUTER JOIN etl.vw_DimItem (nolock) dItem ON ds.SEASON = dItem.ETL__SSID_PAC_SEASON AND ds.EVENT = dItem.ETL__SSID_PAC_ITEM
	AND dItem.ETL__SourceSystem = 'PAC' AND dItem.DimItemId > 0 AND dItem.ETL__IsDeleted = 0

LEFT OUTER JOIN etl.vw_DimEvent (nolock) dEvent ON ds.SEASON = dEvent.ETL__SSID_PAC_SEASON AND ds.EVENT = dEvent.ETL__SSID_PAC_EVENT
	AND dEvent.ETL__SourceSystem = 'PAC' AND dEvent.DimEventId > 0 AND dEvent.ETL__IsDeleted = 0

LEFT OUTER JOIN etl.vw_DimPlan (nolock) dPlan ON ds.SEASON = dPlan.ETL__SSID_PAC_SEASON AND ds.EVENT = dPlan.ETL__SSID_PAC_ITEM
	AND dPlan.ETL__SourceSystem = 'PAC' AND dPlan.DimPlanId > 0 AND dPlan.ETL__IsDeleted = 0

LEFT OUTER JOIN etl.vw_DimSeason (nolock) dSeason ON ds.SEASON = dSeason.ETL__SSID_PAC_SEASON
	AND dSeason.ETL__SourceSystem = 'PAC' AND dSeason.DimSeasonId > 0 AND dSeason.ETL__IsDeleted = 0

LEFT OUTER JOIN etl.vw_DimArena (nolock) dArena ON dEvent.Arena COLLATE SQL_Latin1_General_CP1_CS_AS = dArena.ETL__SSID_PAC_FACILITY
	AND dArena.ETL__SourceSystem = 'PAC' AND dArena.DimArenaId > 0 AND dArena.ETL__IsDeleted = 0

LEFT OUTER JOIN etl.vw_DimPriceLevel (nolock) dPriceLevel ON ds.SEASON = dPriceLevel.ETL__SSID_PAC_SEASON AND dItem.PAC_PTABLE = dPriceLevel.ETL__SSID_PAC_PTABLE AND ds.PL = dPriceLevel.ETL__SSID_PAC_PL
	AND dPriceLevel.ETL__SourceSystem = 'PAC' AND dPriceLevel.DimPriceLevelId > 0 AND dPriceLevel.ETL__IsDeleted = 0

LEFT OUTER JOIN etl.vw_DimSeat (nolock) dSeat ON ds.SEASON = dSeat.ETL__SSID_PAC_SEASON AND ds.LEVEL = dseat.ETL__SSID_PAC_LEVEL AND ds.SECTION = dseat.ETL__SSID_PAC_SECTION AND ds.ROW = dseat.ETL__SSID_PAC_ROW AND ds.SEAT = dseat.ETL__SSID_PAC_SEAT
	AND dSeat.ETL__SourceSystem = 'PAC' AND dSeat.DimSeatId > 0 AND dSeat.ETL__IsDeleted = 0

LEFT OUTER JOIN etl.vw_DimSeatStatus (nolock) dSeatStatus ON ds.SEASON = dSeatStatus.ETL__SSID_PAC_SEASON AND ds.STAT = dSeatStatus.ETL__SSID_PAC_SSTAT
	AND dSeatStatus.ETL__SourceSystem = 'PAC' AND dSeatStatus.DimSeatStatusId > 0 AND dSeatStatus.ETL__IsDeleted = 0


 
--DROP TABLE #DataSet

END 
 
 
 
 















GO
