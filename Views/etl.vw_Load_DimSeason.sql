SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




CREATE VIEW [etl].[vw_Load_DimSeason] AS (

	SELECT  
		'TM' ETL__SourceSystem
		, s.season_id AS ETL__SSID 
		--, NULL ETL__SSID_SEASON --Paciolan
		,  s.season_id ETL__SSID_Season_Id

		, NULL SeasonCode
		, s.name SeasonName
		, s.name SeasonDesc
		, NULL SeasonClass
		, NULL Activity
		, NULL [Status]
		, CAST(CASE WHEN GETDATE() BETWEEN e.EventFirst AND e.EventLast THEN 1 ELSE 0 END AS BIT) IsActive
		, s.season_year SeasonYear
		--, NULL DimSeasonId_Prev
		, s.manifest_id ManifestId
		--, NULL Config_SeasonEventCntFSE

	--SELECT *
	FROM ods.TM_Season s (NOLOCK)
	LEFT OUTER JOIN (
		SELECT e.season_id, MIN(e.event_date) EventFirst, MAX(e.event_date) EventLast, CAST(1 AS BIT) IsActive
		FROM ods.TM_Evnt e (NOLOCK)
		GROUP BY e.season_id
	) e ON e.season_id = s.season_id

)


GO
