SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [ro].[vw_DimPlanType] AS ( SELECT * FROM dbo.DimPlanType_V2 (NOLOCK) )

GO
