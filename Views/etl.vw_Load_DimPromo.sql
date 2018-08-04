SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE VIEW [etl].[vw_Load_DimPromo] AS (

	SELECT  
		'TM' ETL__SourceSystem
		, p.promo_code AS ETL__SSID
		, p.promo_code AS ETL__SSID_Promo
		
		, p.promo_code AS PromoCode
		, MIN(p.promo_code_name) AS PromoName
		, MIN(p.promo_inet_desc) AS PromoDesc
		, MIN(p.promo_type) AS PromoClass

	--SELECT *
	FROM ods.TM_PromoCode (NOLOCK) p
	GROUP BY promo_code
)

GO
