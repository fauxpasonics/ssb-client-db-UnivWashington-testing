SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [etl].[vw_Load_PAC_FactOdet] AS (

	SELECT s.ETL__SSID, s.ETL__SSID_PAC_CUSTOMER, s.ETL__SSID_PAC_SEASON, s.ETL__SSID_PAC_SEQ, s.ETL__SSID_PAC_VMC, s.ETL__SSID_PAC_SVMC, s.DimDateId,
           s.DimTimeId, s.DimTicketCustomerId, s.DimArenaId, s.DimSeasonId, s.DimItemId, s.DimEventId, s.DimPlanId, s.DimPriceLevelId, s.DimPriceTypeId,
           s.DimPriceCodeId, s.DimSeatId_Start, s.DimRepId, s.DimSalesCodeId, s.DimPromoId, s.DimPlanTypeId, s.DimTicketTypeId, s.DimSeatTypeId, s.DimTicketClassId,
           s.OrderDate, s.SSCreatedBy, s.SSUpdatedBy, s.SSCreatedDate, s.SSUpdatedDate, s.QtySeat, s.QtySeatFSE, s.QtySeatRenewable, s.RevenueTicket, s.RevenueFees,
           s.RevenueSurcharge, s.RevenueTax, s.RevenueTotal, s.FullPrice, s.Discount, s.PaidStatus, s.PaidAmount, s.OwedAmount, s.PaymentDateFirst, s.PaymentDateLast,
           s.IsSold, s.IsReserved, s.IsReturned, s.IsPremium, s.IsDiscount, s.IsComp, s.IsHost, s.IsPlan, s.IsPartial, s.IsSingleEvent, s.IsGroup, s.IsBroker,
           s.IsRenewal, s.IsExpanded, s.InRefSource, s.InRefData, s.Custom_Int_1, s.Custom_Int_2, s.Custom_Int_3, s.Custom_Int_4, s.Custom_Int_5, s.Custom_Dec_1,
           s.Custom_Dec_2, s.Custom_Dec_3, s.Custom_Dec_4, s.Custom_Dec_5, s.Custom_DateTime_1, s.Custom_DateTime_2, s.Custom_DateTime_3, s.Custom_DateTime_4,
           s.Custom_DateTime_5, s.Custom_Bit_1, s.Custom_Bit_2, s.Custom_Bit_3, s.Custom_Bit_4, s.Custom_Bit_5, s.Custom_nVarChar_1, s.Custom_nVarChar_2,
           s.Custom_nVarChar_3, s.Custom_nVarChar_4, s.Custom_nVarChar_5, s.CreatedBy, s.UpdatedBy, s.CreatedDate, s.UpdatedDate

	FROM stg.PAC_FactOdet s (NOLOCK)

)


GO
