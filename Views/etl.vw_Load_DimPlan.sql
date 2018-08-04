SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE VIEW [etl].[vw_Load_DimPlan] AS (

	SELECT  
		'TM' ETL__SourceSystem
		, cast(p.event_id as nvarchar(255)) AS ETL__SSID 
		, s.[name] AS ETL__SSID_SEASON
		, p.event_id AS ETL__SSID_ITEM

		, p.event_name AS PlanCode
		, p.team AS PlanName
		, p.event_name_long AS PlanDesc
		, p.plan_abv AS PlanClass
		, s.[name] AS Season
		, p.FSE AS PlanFSE
		, p.plan_type AS PlanType
		, p.total_events AS PlanEventCnt
		--, NULL Config_PlanTicketType
		--, NULL Config_PlanName,
		--, NULL Config_PlanRenewableFSE

	--SELECT *
	FROM ods.TM_Evnt p (NOLOCK) 
	INNER JOIN ods.TM_Season s (NOLOCK) ON p.season_id = s.season_id
	WHERE p.plan_type <> 'N'

)
GO
