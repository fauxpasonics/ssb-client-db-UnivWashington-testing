SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [etl].[vw_DimPriceCode] AS ( SELECT * FROM dbo.DimPriceCode_V2 )
GO