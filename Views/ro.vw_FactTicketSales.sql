SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE VIEW [ro].[vw_FactTicketSales] AS ( SELECT * FROM dbo.FactTicketSales_V2 (NOLOCK) )
GO
