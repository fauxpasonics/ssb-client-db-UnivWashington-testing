SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [etl].[vw_DimSeatType] AS ( SELECT * FROM dbo.DimSeatType_V2 (NOLOCK) )

GO