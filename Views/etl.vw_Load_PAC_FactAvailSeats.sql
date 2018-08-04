SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [etl].[vw_Load_PAC_FactAvailSeats] AS (

	SELECT  
		ETL__SSID, ETL__SSID_PAC_SEASON, ETL__SSID_PAC_EVENT, ETL__SSID_PAC_LEVEL, ETL__SSID_PAC_SECTION, ETL__SSID_PAC_ROW, ETL__SSID_PAC_SEAT, DimDateId, DimTimeId,
        DimArenaId, DimSeasonId, DimItemId, DimEventId, DimPlanId, DimPriceLevelId, DimPriceTypeId, DimPriceCodeId, DimSeatId_Start, DimSeatStatusId,
        DimPlanTypeId, DimTicketTypeId, DimSeatTypeId, DimTicketClassId, PostedDateTime, QtySeat, SubTotal, Fees, Taxes, Total

	FROM stg.PAC_FactAvailSeats (NOLOCK)

)




GO
