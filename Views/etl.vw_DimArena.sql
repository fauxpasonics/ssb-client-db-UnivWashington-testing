SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [etl].[vw_DimArena] AS ( SELECT * FROM dbo.DimArena_V2 )
GO
