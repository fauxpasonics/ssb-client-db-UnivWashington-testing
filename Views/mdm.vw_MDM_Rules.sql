SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- View

CREATE VIEW [mdm].[vw_MDM_Rules] AS
(
SELECT dc.dimcustomerid
, dnr.DNR 
, sth.STH
, sc.MaxSeatCount
, maxPurchaseDate
, dc.accountid
FROM dbo.dimcustomer dc
LEFT JOIN (
	SELECT DISTINCT dimcustomerid, 1 AS 'DNR'
	FROM dbo.dimcustomer dc (NOLOCK)
	JOIN dbo.ADV_CONTACT donor (NOLOCK)
		ON dc.SourceSystem = 'Paciolan' AND dc.SSID = donor.Patronid
	) dnr on dnr.DimCustomerId = dc.DimCustomerId
LEFT JOIN (
	SELECT DISTINCT dc.dimcustomerid, 1 AS 'STH' 
	FROM dbo.FactTicketSales_V2 fts
	INNER JOIN dbo.DimSeason_V2 ds (NOLOCK)
		ON fts.DimSeasonId = ds.DimSeasonId
	INNER JOIN dbo.Dimcustomer dc (NOLOCK)
		ON dc.SourceSystem = 'Paciolan' AND fts.ETL__SSID_PAC_CUSTOMER = dc.ssid
	WHERE fts.DimTicketTypeId = 1 
	AND ISNULL(ds.Config_SeasonYear, SeasonYear) >= DATEPART(YEAR,GETDATE())-3
	
	) sth ON dc.dimcustomerid = sth.dimcustomerid
LEFT JOIN (
			SELECT dc.dimcustomerid, COUNT(*) MaxSeatCount
			FROM TK_SEAT_SEAT odet (NOLOCK)
			INNER JOIN dbo.DimCustomer dc (NOLOCK)
				ON dc.SourceSystem = 'Paciolan' AND dc.SSID = odet.CUSTOMER
			GROUP BY dc.DimCustomerId) sc 
					ON dc.DimCustomerId = sc.DimCustomerId
LEFT JOIN (
		SELECT dc.DimCustomerID, MAX(I_DATE) MaxPurchaseDate 
		FROM dbo.TK_ODET odet WITH(NOLOCK)
		INNER JOIN dbo.DimCustomer dc (NOLOCK)
				ON dc.SourceSystem = 'Paciolan' AND dc.SSID = odet.CUSTOMER
		GROUP BY dc.DimCustomerId
) purchasedate ON purchasedate.DimCustomerId = dc.DimCustomerId





)









GO
