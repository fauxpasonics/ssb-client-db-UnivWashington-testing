SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

			CREATE VIEW [ro].[vw_DimTime]
			AS

				SELECT *
				FROM dbo.DimTime (NOLOCK)
GO
