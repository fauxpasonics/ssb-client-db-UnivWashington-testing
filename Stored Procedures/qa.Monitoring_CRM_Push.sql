SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

--create schema qa authorization dbo

create PROCEDURE [qa].[Monitoring_CRM_Push]
@ClientName VARCHAR(50)
AS

-- =============================================
-- Author:      Jay Graves
-- Create date: 2018-04-06
-- Description: Monitors CRM Integration
-- Change Log:
-- Date			Editor			Description
-- 2018-04-17	Luke Miles		Fixed DateAdd calculation to acurately compute 1.5 days ago
-- =============================================
SELECT ClientName, 
CASE
	WHEN LastRunEnd > DATEADD(hh,-36,GETDATE()) THEN 'Nominal'
	ELSE TRY_CAST(LastRunEnd AS VARCHAR(50)) 
	END AS Status
FROM CentralIntelligence.etl.CRM_Settings
WHERE ClientName = @ClientName
GO
