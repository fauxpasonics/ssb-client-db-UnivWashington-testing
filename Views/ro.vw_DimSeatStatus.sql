SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [ro].[vw_DimSeatStatus] AS ( SELECT * FROM dbo.DimSeatStatus_V2 (NOLOCK) )

GO
