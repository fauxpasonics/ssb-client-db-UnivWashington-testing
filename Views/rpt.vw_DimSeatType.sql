SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [rpt].[vw_DimSeatType] AS (SELECT * FROM dbo.DimSeatType (NOLOCK))


GO
