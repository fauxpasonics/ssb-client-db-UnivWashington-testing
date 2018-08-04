SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [etl].[vw_Load_PAC_FactTicketActivity]
AS
(
	SELECT ETL__SSID, ETL__SSID_PAC_SEASON, ETL__SSID_PAC_TRANS_NO, DimDateId, DimTimeId, DimArenaId, DimSeasonId, DimItemId, DimEventId, DimPlanId, DimSeatId_Start,
           DimTicketCustomerId, DimTicketCustomerId_Recipient, DimActivityId, TransDateTime, QtySeat, SubTotal, Fees, Taxes, Total, UpdatedBy, UpdatedDate,
           PAC_MP_BOCHG, PAC_MP_BUY_AMT, PAC_MP_BUY_NET, PAC_MP_BUYER, PAC_MP_DIFF, PAC_MP_DMETH_TYPE, PAC_MP_NETITEM, PAC_MP_OWNER, PAC_MP_SELLCR, PAC_MP_SELLER,
           PAC_MP_SELLTIXAMT, PAC_MP_SHPAID, PAC_MP_SOCHG, PAC_MP_TIXAMT, PAC_MP_PL
	FROM stg.PAC_FactTicketActivity
)
GO
