SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE PROCEDURE [etl].[PAC_LoadFactInventory_Resold]
(
	@BatchId UNIQUEIDENTIFIER = '00000000-0000-0000-0000-000000000000',
	@Options NVARCHAR(MAX) = null
)

AS
BEGIN

	UPDATE fi
	SET fi.ETL__UpdatedDate = GETUTCDATE()	
	, fi.FactTicketActivityId_Resold = NULL
	FROM etl.vw_FactInventory fi
	LEFT OUTER JOIN etl.vw_FactTicketActivity (NOLOCK) f ON fi.FactTicketActivityId_Resold = f.FactTicketActivityId
	WHERE fi.FactTicketActivityId_Resold IS NOT NULL
	AND f.FactTicketActivityId IS NULL

	
	SELECT f.DimEventId, dSeatEnd.DimSeatId, f.FactTicketActivityId
	INTO #stg

	FROM etl.vw_FactTicketActivity (NOLOCK) f
	INNER JOIN etl.vw_DimEvent (NOLOCK) dEvent on f.DimEventId = dEvent.DimEventId
	INNER JOIN etl.vw_DimSeat (NOLOCK) dSeat ON f.DimSeatId_Start = dSeat.DimSeatId
	INNER JOIN etl.vw_DimSeat (NOLOCK) dSeatEnd
		ON dSeat.ETL__SourceSystem = dSeatEnd.ETL__SourceSystem
		AND dSeat.ETL__SSID_PAC_SEASON = dSeatEnd.ETL__SSID_PAC_SEASON 
		AND dSeat.ETL__SSID_PAC_LEVEL = dSeatEnd.ETL__SSID_PAC_LEVEL
		AND dSeat.ETL__SSID_PAC_SECTION = dSeatEnd.ETL__SSID_PAC_SECTION
		AND dSeat.ETL__SSID_PAC_ROW = dSeatEnd.ETL__SSID_PAC_ROW
		AND dSeatEND.SortOrderSeat between dSeat.SortOrderSeat and (dSeat.SortOrderSeat + f.QtySeat - 1)

	WHERE dEvent.Config_IsFactInventoryEligible = 1

	CREATE NONCLUSTERED INDEX [IDX_BusinessKey] ON #stg (DimEventId, DimSeatId)


	UPDATE fi
	SET fi.ETL__UpdatedDate = GETUTCDATE()
	, fi.FactTicketActivityId_Resold = s.FactTicketActivityId
	FROM etl.vw_FactInventory fi
	INNER JOIN #stg s ON fi.DimEventId = s.DimEventId AND fi.DimSeatId = s.DimSeatId
	WHERE ISNULL(fi.FactTicketActivityId_Resold, -987) <> ISNULL(s.FactTicketActivityId, -987)

	DROP TABLE #stg

END











GO
