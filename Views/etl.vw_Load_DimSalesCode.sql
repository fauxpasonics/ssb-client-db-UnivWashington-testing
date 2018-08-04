SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [etl].[vw_Load_DimSalesCode] AS (

	SELECT  
		'TM' ETL__SourceSystem
		, sc.sell_location_id AS ETL__SSID
		, NULL AS ETL__SSID_SALECODE --Paciolan specific
		, sc.sell_location_id AS [ETL__SSID_Sell_Location_Id]
		, cast(sc.sell_location_code as nvarchar(50)) AS SalesCode
		, cast(sc.sell_location_name as nvarchar(200)) AS SalesCodeName
		, cast(sc.sell_location_desc as nvarchar(500)) AS SalesCodeDesc
		, cast(null as nvarchar(50))  SalesCodeClass

	--SELECT *
	FROM ods.TM_SellLocation sc (NOLOCK) 

)
GO
