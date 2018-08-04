SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





CREATE PROCEDURE [etl].[Cust_DimPlanProcessing_archiveAMEITIN]
(
	@BatchId INT = 0,
	@LoadDate DATETIME = NULL,
	@Options NVARCHAR(MAX) = NULL
)
AS



BEGIN



/*****************************************************************************************************************
													FullSeasonEventCnt
******************************************************************************************************************/



--------------Football--------------------------------

UPDATE dp
SET dp.FullSeasonEventCnt = 7
FROM    dbo.DimPlan dp
WHERE  dp.DimSeasonId IN ('97', '23', '49', '77') --2014 Husky Football, 2015 Husky Football, 2016 Husky Football, 2016 Husky Football

--------------Men's Basketball--------------------------------

UPDATE dp
SET dp.FullSeasonEventCnt = 16
FROM    dbo.DimPlan dp
WHERE  dp.DimSeasonId IN ('9') --2014-15 Men's Basketball

UPDATE dp
SET dp.FullSeasonEventCnt = 18
FROM    dbo.DimPlan dp
WHERE  dp.DimSeasonId IN ('36') --2015-16 Men's Basketball


UPDATE dp
SET dp.FullSeasonEventCnt = 17
FROM    dbo.DimPlan dp
WHERE  dp.DimSeasonId IN ('61') --2016-17 Men's Basketball

--------------Women's Basketball--------------------------------
UPDATE dp
SET dp.FullSeasonEventCnt = 13
FROM    dbo.DimPlan dp
WHERE  dp.DimSeasonId IN ('10') --2014-15 Men's Basketball

UPDATE dp
SET dp.FullSeasonEventCnt = 15
FROM    dbo.DimPlan dp
WHERE  dp.DimSeasonId IN ('39') --2015-16 Men's Basketball

UPDATE dp
SET dp.FullSeasonEventCnt = 16
FROM    dbo.DimPlan dp
WHERE  dp.DimSeasonId IN ('66') --2016-17 Men's Basketball

--------------Baseball------------------------------------------
UPDATE dp
SET dp.FullSeasonEventCnt = 28
FROM    dbo.DimPlan dp
WHERE  dp.DimSeasonId IN ('29') --2015 Baseball

UPDATE dp
SET dp.FullSeasonEventCnt = 29
FROM    dbo.DimPlan dp
WHERE  dp.DimSeasonId IN ('56') --2016 Baseball

UPDATE dp
SET dp.FullSeasonEventCnt = 27
FROM    dbo.DimPlan dp
WHERE  dp.DimSeasonId IN ('89') --2017 Baseball

--------------Softball------------------------------------------
UPDATE dp
SET dp.FullSeasonEventCnt = 16
FROM    dbo.DimPlan dp
WHERE  dp.DimSeasonId IN ('20') --2015 Softball

UPDATE dp
SET dp.FullSeasonEventCnt = 15
FROM    dbo.DimPlan dp
WHERE  dp.DimSeasonId IN ('58', '88') --2016 Softball, 2017 Softball




















END

GO
