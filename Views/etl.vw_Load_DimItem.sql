SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



CREATE VIEW [etl].[vw_Load_DimItem] AS (

	SELECT  
		'TM' ETL__SourceSystem
		, i.event_id  AS ETL__SSID 
		, s.[name] AS ETL__SSID_SEASON
		, i.event_id AS ETL__SSID_ITEM
		, i.event_name AS ItemCode
		, i.team AS ItemName
		, i.event_name_long AS ItemDesc
		, NULL AS ItemClass
		, s.[name] Season


	--SELECT *
	FROM ods.TM_Evnt i (NOLOCK)
	INNER JOIN ods.TM_Season s (NOLOCK) ON i.season_id = s.season_id

)
GO
