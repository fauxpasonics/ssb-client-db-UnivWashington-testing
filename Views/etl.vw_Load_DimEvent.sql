SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE VIEW [etl].[vw_Load_DimEvent] AS (

	SELECT  
		'TM' ETL__SourceSystem
		, e.Event_id AS ETL__SSID 
		, e.Event_id ETL__SSID_Event_id
		, e.Event_name AS EventCode
		, e.team AS EventName
		, e.event_name_long AS EventDesc
		, NULL AS EventClass
		, a.arena_name AS Arena 
		, s.[name] AS Season 
		, CAST(e.event_date AS DATE) AS EventDate
		, e.event_time EventTime
		, (CAST(event_date AS DATETIME) + CAST(event_time AS DATETIME)) AS EventDateTime
		, s.manifest_id AS ManifestId 

	--SELECT *
	FROM ods.TM_Evnt e (NOLOCK)
	INNER JOIN ods.TM_Season s (NOLOCK) ON e.season_id = s.season_id
	INNER JOIN ods.TM_Arena a (NOLOCK) ON a.arena_id = s.arena_id


)


GO
