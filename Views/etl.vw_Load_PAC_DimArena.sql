SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [etl].[vw_Load_PAC_DimArena] AS (

SELECT  

      ZID COLLATE SQL_Latin1_General_CP1_CI_AS AS ETL__SSID 
      , ZID AS ETL__SSID_PAC_FACILITY
      , FACILITY COLLATE SQL_Latin1_General_CP1_CI_AS AS ArenaCode
      , NAME AS ArenaName
      , NULL ArenaDesc
      , NULL ArenaClass

FROM    dbo.TK_FACILITY (NOLOCK)

)


GO
