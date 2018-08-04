SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [etl].[PAC_LoadFacts]
(
	@BatchId NVARCHAR(50) = '00000000-0000-0000-0000-000000000000',
	@Options NVARCHAR(MAX) = null
)

AS
BEGIN

	EXEC etl.Load_stg_FactTicketSalesBaseEvents

	EXEC etl.PAC_Stage_FactTicketSales_Events

	EXEC [etl].[PAC_FactTicketSales_DeleteReturns] 

	EXEC etl.Cust_FactTicketSalesProcessing

	EXEC [etl].[SSB_ProcessStandardMerge_Dev_20170730] @BatchId = '00000000-0000-0000-0000-000000000000', @Target = 'dbo.FactTicketSales_V2', @Source = 'etl.vw_Load_PAC_FactTicketSales', @BusinessKey = 'ETL__SSID_PAC_CUSTOMER, ETL__SSID_PAC_SEASON, ETL__SSID_PAC_ITEM, ETL__SSID_PAC_EVENT, ETL__SSID_PAC_E_PL, ETL__SSID_PAC_E_PT, ETL__SSID_PAC_E_STAT, ETL__SSID_PAC_E_PRICE, ETL__SSID_PAC_E_DAMT', @SourceSystem = 'PAC'
	

	EXEC etl.PAC_Stage_FactOdet @BatchId = @BatchId, @Options = @Options
	
	EXEC etl.Cust_FactOdetProcessing @BatchId = @BatchId, @Options = @Options

	DELETE f
	FROM etl.vw_FactOdet f
	LEFT OUTER JOIN dbo.TK_ODET_EVENT_SBLS s (NOLOCK) ON
		f.ETL__SSID_PAC_SEASON = s.SEASON
		AND f.ETL__SSID_PAC_CUSTOMER = s.CUSTOMER
		AND f.ETL__SSID_PAC_SEQ = s.SEQ
		AND f.ETL__SSID_PAC_VMC = s.VMC
		AND f.ETL__SSID_PAC_SVMC = s.SVMC
	WHERE s.SEASON IS NULL

	EXEC [etl].[SSB_StandardModelLoad] @BatchId = '00000000-0000-0000-0000-000000000000', @Target = 'etl.vw_FactOdet', @Source = 'etl.vw_Load_PAC_FactOdet', @BusinessKey = 'ETL__SSID_PAC_CUSTOMER, ETL__SSID_PAC_SEASON, ETL__SSID_PAC_SEQ, ETL__SSID_PAC_VMC, ETL__SSID_PAC_SVMC', @SourceSystem = 'PAC'


	EXEC etl.PAC_LoadFactAttendance


	EXEC etl.PAC_LoadFactInventory	

	UPDATE fi
	SET fi.ETL__UpdatedDate = GETDATE()
	, fi.FactAttendanceId = fa.FactAttendanceId
	--SELECT TOP 1000 *
	FROM etl.vw_FactInventory fi
	INNER JOIN etl.vw_FactAttendance fa ON fi.DimEventId = fa.DimEventId AND fi.DimSeatId = fa.DimSeatId
	WHERE ISNULL(fi.FactAttendanceId, 0) <> ISNULL(fa.FactAttendanceId, 0)


	EXEC [etl].[PAC_Stage_FactAvailSeats] @BatchId = @BatchId, @Options = @Options

	DELETE t
	FROM etl.vw_FactAvailSeats t
	LEFT OUTER JOIN dbo.TK_SEAT_SEAT (NOLOCK) s 
		ON t.ETL__SSID_PAC_SEASON = s.SEASON
		AND t.ETL__SSID_PAC_EVENT = s.EVENT
		AND t.ETL__SSID_PAC_LEVEL = s.LEVEL
		AND t.ETL__SSID_PAC_SECTION = s.SECTION
		AND t.ETL__SSID_PAC_ROW = s.ROW
		AND t.ETL__SSID_PAC_SEAT = s.SEAT
		AND s.CUSTOMER IS NULL
		AND s.SEAT IS NOT NULL
	WHERE s.SEASON IS NULL

	EXEC [etl].[SSB_ProcessStandardMerge_Dev_20170730] @BatchId = '00000000-0000-0000-0000-000000000000', @Target = 'etl.vw_FactAvailSeats', @Source = 'etl.vw_Load_PAC_FactAvailSeats'
	, @BusinessKey = 'ETL__SSID_PAC_SEASON, ETL__SSID_PAC_EVENT, ETL__SSID_PAC_LEVEL, ETL__SSID_PAC_SECTION, ETL__SSID_PAC_ROW, ETL__SSID_PAC_SEAT', @SourceSystem = 'PAC'
		


	EXEC etl.PAC_Stage_FactTicketActivity

	EXEC [etl].[SSB_ProcessStandardMerge_Dev_20170730] @BatchId = '00000000-0000-0000-0000-000000000000', @Target = 'etl.vw_FactTicketActivity', @Source = 'etl.vw_Load_PAC_FactTicketActivity'
	, @BusinessKey = 'ETL__SSID_PAC_SEASON, ETL__SSID_PAC_TRANS_NO', @SourceSystem = 'PAC'



	EXEC etl.PAC_LoadFactInventory_Avail

	EXEC etl.PAC_LoadFactInventory_Resold

	EXEC [etl].[PAC_LoadFactInventory_Sales]


END








GO
