SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [etl].[vw_DimPlan] AS ( SELECT * FROM dbo.DimPlan_V2 )
GO
