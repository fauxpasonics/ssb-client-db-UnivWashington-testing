SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




CREATE VIEW [etl].[vw_Load_DimPriceCode] as (



	SELECT 
	cast(pc.event_id as varchar(20)) + ':' + cast(pc.price_code as varchar(20)) as [ETL__SSID]
	, pc.event_id AS [ETL__SSID_Event_id]
	, pc.price_code AS [ETL_SSID_Price_Code]
	, NULL AS Season
	, NULL AS Item
	, pc.price_code as PriceCode
	, pc.price_code_desc as PriceCodeDesc
	, null as PriceCodeClass
	, case when len(pc.price_code) >= 1 then  substring(pc.price_code,1,1) end as PC1
	, case when len(pc.price_code) >= 2 then  substring(pc.price_code,2,1) end as PC2
	, case when len(pc.price_code) >= 3 then  substring(pc.price_code,3,1) end as PC3
	, case when len(pc.price_code) >= 4 then  substring(pc.price_code,4,1) end as PC4
	, pc.price_code_group as PriceCodeGroup

	FROM ods.TM_PriceCode pc (NOLOCK)



)




































GO
