SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE PROCEDURE [etl].[PAC_LoadFactInventory_Sales]
(
	@BatchId UNIQUEIDENTIFIER = '00000000-0000-0000-0000-000000000000',
	@Options NVARCHAR(MAX) = null
)

AS
BEGIN


	SELECT f.DimEventId, dSeatEnd.DimSeatId, f.FactOdetId, dSeatStatus.DimSeatStatusid
	INTO #FactTicketSales

	--SELECT COUNT(*)
	--SELECT TOP 1000  dSeat.ETL__SourceSystem, dSeat.ETL__SSID_PAC_SEASON, dSeat.ETL__SSID_PAC_LEVEL, dSeat.ETL__SSID_PAC_SECTION, dSeat.ETL__SSID_PAC_ROW
	FROM etl.vw_FactOdet (NOLOCK) f
	INNER JOIN etl.vw_DimEvent (NOLOCK) dEvent on f.DimEventId = dEvent.DimEventId
	INNER JOIN etl.vw_DimSeat (NOLOCK) dSeat ON f.DimSeatId_Start = dSeat.DimSeatId
	LEFT OUTER JOIN (
		SELECT ETL__SSID_PAC_SEASON, ETL__SSID_PAC_SSTAT, MIN(DimSeatStatusId) DimSeatStatusId
		FROM etl.vw_DimSeatStatus
		WHERE ETL__SourceSystem = 'PAC'
		AND ETL__SSID_PAC_SSTAT = 'X'
		GROUP BY ETL__SSID_PAC_SEASON, ETL__SSID_PAC_SSTAT
	) dSeatStatus ON f.ETL__SSID_PAC_SEASON = dSeatStatus.ETL__SSID_PAC_SEASON
	INNER JOIN etl.vw_DimSeat (NOLOCK) dSeatEnd
		ON dSeat.ETL__SourceSystem = dSeatEnd.ETL__SourceSystem
		AND dSeat.ETL__SSID_PAC_SEASON = dSeatEnd.ETL__SSID_PAC_SEASON 
		AND dSeat.ETL__SSID_PAC_LEVEL = dSeatEnd.ETL__SSID_PAC_LEVEL
		AND dSeat.ETL__SSID_PAC_SECTION = dSeatEnd.ETL__SSID_PAC_SECTION
		AND dSeat.ETL__SSID_PAC_ROW = dSeatEnd.ETL__SSID_PAC_ROW
		AND dSeatEND.SortOrderSeat between dSeat.SortOrderSeat and (dSeat.SortOrderSeat + f.QtySeat - 1)

	WHERE ISNULL(dEvent.Config_IsFactInventoryEligible, 1) = 1

	CREATE NONCLUSTERED INDEX [IDX_BusinessKey] ON #FactTicketSales (DimEventId, DimSeatId)


	--UPDATE fi
	--SET fi.ETL__UpdatedDate = GETUTCDATE()	
	--, fi.FactOdetId = NULL
	--, fi.DimSeatStatusId = 0
	--FROM etl.vw_FactInventory fi
	--LEFT OUTER JOIN etl.vw_FactOdet (NOLOCK) fts ON fi.FactOdetId = fts.FactOdetId
	--WHERE fi.FactOdetId IS NOT NULL
	--AND fts.FactOdetId IS NULL


	UPDATE fi
	SET fi.ETL__UpdatedDate = GETUTCDATE()	
	, fi.FactOdetId = NULL
	, fi.DimSeatStatusId = 0
	FROM etl.vw_FactInventory fi
	LEFT OUTER JOIN #FactTicketSales s ON fi.DimEventId = s.DimEventId AND fi.DimSeatId = s.DimSeatId AND fi.FactOdetId = s.FactOdetId
	WHERE fi.FactOdetId IS NOT NULL	
	AND s.DimEventId IS NULL
	

	UPDATE fi
	SET fi.ETL__UpdatedDate = GETUTCDATE()
	, fi.DimSeatStatusid = s.DimSeatStatusid
	, fi.FactOdetId = s.FactOdetId
	FROM etl.vw_FactInventory fi
	INNER JOIN #FactTicketSales s ON fi.DimEventId = s.DimEventId AND fi.DimSeatId = s.DimSeatId
	WHERE ISNULL(fi.DimSeatStatusId, -987) <> ISNULL(s.DimSeatStatusId, -987) OR ISNULL(fi.FactOdetId, -987) <> ISNULL(s.FactOdetId, -987)

	DROP TABLE #FactTicketSales

END














GO
