SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE VIEW [rpt].[vw_DimEventHeader] AS (SELECT * FROM dbo.DimEventHeader (NOLOCK) WHERE IsDeleted = 0) 


GO