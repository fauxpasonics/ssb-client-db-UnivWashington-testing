SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [etl].[vw_Load_TM_DimEvent] AS (

	SELECT  
		e.Event_id AS ETL__SSID 
		, e.Event_id ETL__SSID_TM_event_id
		, e.Event_name AS EventCode
		, e.team AS EventName
		, e.event_name_long AS EventDesc

		, a.arena_name AS Arena 
		, s.name AS Season 
		
		, CAST(e.event_date AS DATE) AS EventDate
		, e.event_time EventTime
		, (CAST(event_date AS DATETIME) + CAST(event_time AS DATETIME)) AS EventDateTime
		 
		, s.arena_id TM_arena_id
		, e.Season_id TM_season_id
		, s.manifest_id AS TM_manifest_id
		, e.Major_Category AS TM_major_category
		, e.Minor_Category AS TM_minor_category

		, e.event_name TM_event_name
		, e.Team TM_Team
		, e.event_name_long TM_event_name_long
		, e.Tm_event_name TM__host_event_name
		, e.event_report_group TM_event_report_group
		, e.plan_type TM_plan_type
		, e.Event_Type TM_Event_Type
		, e.plan_abv TM_plan_abv
		, e.[Enabled] TM_Enabled
		, e.Returnable TM_Returnable
		, e.Barcode_Status TM_Barcode_Status
		, e.Print_Ticket_Ind TM_Print_Ticket_Ind
		, e.exchange_price_opt TM_exchange_price_opt

	--SELECT *
	FROM ods.TM_Evnt e (NOLOCK)
	LEFT OUTER JOIN ods.TM_Season s (NOLOCK) ON e.season_id = s.season_id
	LEFT OUTER JOIN ods.TM_Arena a (NOLOCK) ON s.arena_id = a.arena_id
	WHERE e.[Plan] = 'N'


)








GO
