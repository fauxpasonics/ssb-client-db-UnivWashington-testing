SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [ro].[vw_SeasonFilter]
AS
WITH CTE_Seasons
AS (
		SELECT DISTINCT
			ds.DimSeasonId,
			ISNULL(ds.Config_SeasonYear, ds.SeasonYear) AS SeasonYear,
			ds.DimSeasonId_Prev,
			ds.SeasonName,
			ds.IsActive
		FROM ro.vw_DimSeason ds --changed this to pull directly from Dimseason bc Paciolan is much less complicated
		WHERE 1=1
			AND ds.Config_Org IS NOT NULL 
	)
SELECT
	s.DimSeasonId, MAX(s.SeasonYear) AS SeasonYear, MAX(s.SeasonName) AS SeasonName, CASE WHEN MAX(s.SeasonYear) = cs.SeasonYear THEN 1 ELSE 0 END AS IsActive
FROM (
		SELECT s.DimSeasonId, s.SeasonYear, s.SeasonName
		FROM CTE_Seasons s
		WHERE s.IsActive = 1
		UNION
		SELECT DISTINCT
			ds.DimSeasonId,
			ds.SeasonYear,
			ds.SeasonName
		FROM ro.vw_DimSeason ds
		INNER JOIN CTE_Seasons s
			ON  ds.DimSeasonId = s.DimSeasonId_Prev
		WHERE ds.Config_Org IS NOT NULL

	) S
CROSS JOIN (
		SELECT MAX(SeasonYear) SeasonYear
		FROM CTE_Seasons
	) cs
GROUP BY DimSeasonId, cs.SeasonYear
GO
