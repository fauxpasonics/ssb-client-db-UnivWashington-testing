SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [etl].[vw_FactHeldSeats] AS ( SELECT * FROM dbo.FactHeldSeats_V2 (NOLOCK) )
GO