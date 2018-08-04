SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [etl].[TI_ReportBase_Build]
AS
BEGIN

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	-- Create #SalesBase --------------------------------------------------------------------------------------------------

	CREATE TABLE #SalesBase (
		SEASON VARCHAR(15) COLLATE SQL_Latin1_General_CP1_CS_AS
	   ,CUSTOMER VARCHAR(20) COLLATE SQL_Latin1_General_CP1_CS_AS
	   ,ITEM VARCHAR(32) COLLATE SQL_Latin1_General_CP1_CS_AS
	   ,E_PL VARCHAR(10) COLLATE SQL_Latin1_General_CP1_CS_AS
	   ,I_PT VARCHAR(32) COLLATE SQL_Latin1_General_CP1_CS_AS
	   ,I_PRICE NUMERIC(18, 2)
	   ,I_DAMT NUMERIC(18, 2)
	   ,ORDQTY BIGINT
	   ,ORDTOTAL NUMERIC(18, 2)
	);

	INSERT INTO #SalesBase (
		SEASON
	   ,CUSTOMER
	   ,ITEM
	   ,E_PL
	   ,I_PT
	   ,I_PRICE
	   ,I_DAMT
	   ,ORDQTY
	   ,ORDTOTAL
	)
	SELECT
		 tkTrans.SEASON
		,tkTransItem.CUSTOMER
		,tkTransItem.ITEM
		,tkTransItemEvent.E_PL
		,tkTransItem.I_PT
		,tkTransItem.I_PRICE
		,tkTransItem.I_DAMT
		,SUM(ISNULL(tkTransItem.I_OQTY_TOT, 0)) ORDQTY
		,SUM(ISNULL(tkTransItem.I_OQTY_TOT, 0) * ( ISNULL(I_PRICE, 0)) - ISNULL(I_DAMT, 0)) AS ORDTOTAL
	FROM dbo.TK_TRANS ( NOLOCK ) tkTrans
	INNER JOIN dbo.TK_TRANS_ITEM ( NOLOCK ) tkTransItem
		ON  tkTrans.SEASON = tkTransItem.SEASON
		AND tkTrans.TRANS_NO = tkTransItem.TRANS_NO
	LEFT JOIN  (
			SELECT
				 subtkTransItemEvent.SEASON
				,MAX(ISNULL(subtkTransItemEvent.E_PL, 99999)) E_PL
				,subtkTransItemEvent.TRANS_NO
				,subtkTransItemEvent.VMC
			FROM dbo.TK_TRANS_ITEM_EVENT ( NOLOCK ) subtkTransItemEvent
			INNER JOIN dbo.TI_ReportBaseSeasons ( NOLOCK ) subpSeasons
				ON  subtkTransItemEvent.SEASON COLLATE SQL_Latin1_General_CP1_CS_AS = subpSeasons.Season COLLATE SQL_Latin1_General_CP1_CS_AS
			GROUP BY   
				 subtkTransItemEvent.SEASON
				,subtkTransItemEvent.TRANS_NO
				,subtkTransItemEvent.VMC
		) tkTransItemEvent
		ON  tkTransItem.SEASON = tkTransItemEvent.SEASON
		AND tkTransItem.TRANS_NO = tkTransItemEvent.TRANS_NO
		AND tkTransItem.VMC = tkTransItemEvent.VMC
	INNER JOIN dbo.TK_ITEM ( NOLOCK ) tkItem
		ON  tkTransItem.SEASON = tkItem.SEASON
		AND tkTransItem.ITEM = tkItem.ITEM
	INNER JOIN dbo.TI_ReportBaseSeasons ( NOLOCK ) Seasons
		ON  tkTrans.SEASON COLLATE SQL_Latin1_General_CP1_CS_AS = Seasons.Season COLLATE SQL_Latin1_General_CP1_CS_AS
	----- does the where clause apply to texas? 
	WHERE tkTrans.SOURCE <> 'TK.ERES.SH.PURCHASE'
		AND (
				tkTrans.E_STAT NOT IN ('MI', 'MO', 'TO', 'TI', 'EO', 'EI')
				OR tkTrans.E_STAT IS NULL
			)
	GROUP BY   
		 tkTrans.SEASON
		,tkTransItem.CUSTOMER
		,tkTransItem.ITEM
		,tkTransItemEvent.E_PL
		,tkTransItem.I_PT
		,tkTransItem.I_PRICE
		,tkTransItem.I_DAMT;

	-- Create #PaidFinal --------------------------------------------------------------------------------------------------

	CREATE TABLE #PaidFinal (
		CUSTOMER VARCHAR(20) COLLATE SQL_Latin1_General_CP1_CS_AS
	   ,MINPAYMENTDATE DATETIME
	   ,ITEM VARCHAR(32) COLLATE SQL_Latin1_General_CP1_CS_AS
	   ,E_PL VARCHAR(10) COLLATE SQL_Latin1_General_CP1_CS_AS
	   ,I_PT VARCHAR(32) COLLATE SQL_Latin1_General_CP1_CS_AS
	   ,I_PRICE NUMERIC(18, 2)
	   ,I_DAMT NUMERIC(18, 2)
	   ,PAIDTOTAL NUMERIC(18, 2)
	   ,SEASON VARCHAR(15) COLLATE SQL_Latin1_General_CP1_CS_AS
	);

	INSERT INTO #PaidFinal (
		CUSTOMER
	   ,MINPAYMENTDATE
	   ,ITEM
	   ,E_PL
	   ,I_PT
	   ,I_PRICE
	   ,I_DAMT
	   ,PAIDTOTAL
	   ,SEASON
	)
	SELECT
		 tkTransItem.CUSTOMER
		,MIN(tkTrans.DATE) minPaymentDate
		,tkTransItem.ITEM
		,tkTransItemEvent.E_PL
		,tkTransItem.I_PT
		,tkTransItem.I_PRICE
		,tkTransItem.I_DAMT
		,SUM(ISNULL(( tkTransItemPaymode.I_PAY_PAMT ), 0)) PAIDTOTAL
		,tkTransItem.SEASON
	FROM dbo.TK_TRANS tkTrans
	INNER JOIN dbo.TK_TRANS_ITEM tkTransItem
		ON  tkTrans.SEASON = tkTransItem.SEASON
		AND tkTrans.TRANS_NO = tkTransItem.TRANS_NO
	LEFT JOIN (
			SELECT
				 subtkTransItemEvent.SEASON
				,MAX(ISNULL(subtkTransItemEvent.E_PL, 99999)) E_PL
				,subtkTransItemEvent.TRANS_NO
				,subtkTransItemEvent.VMC
			FROM dbo.TK_TRANS_ITEM_EVENT ( NOLOCK ) subtkTransItemEvent
			INNER JOIN dbo.TI_ReportBaseSeasons ( NOLOCK ) subpSeasons
				ON  subtkTransItemEvent.SEASON COLLATE Latin1_General_CS_AS = subpSeasons.Season COLLATE Latin1_General_CS_AS
			GROUP BY 
				 subtkTransItemEvent.SEASON
				,subtkTransItemEvent.TRANS_NO
				,subtkTransItemEvent.VMC
		) tkTransItemEvent
		ON  tkTransItem.SEASON = tkTransItemEvent.SEASON
		AND tkTransItem.TRANS_NO = tkTransItemEvent.TRANS_NO
		AND tkTransItem.VMC = tkTransItemEvent.VMC
	INNER JOIN dbo.TK_TRANS_ITEM_PAYMODE tkTransItemPaymode
		ON  tkTransItem.SEASON = tkTransItemPaymode.SEASON
		AND tkTransItem.TRANS_NO = tkTransItemPaymode.TRANS_NO
		AND tkTransItem.VMC = tkTransItemPaymode.VMC
	INNER JOIN dbo.TK_ITEM ( NOLOCK ) tkItem
		ON  tkTransItem.SEASON = tkItem.SEASON
		AND tkTransItem.ITEM = tkItem.ITEM
	INNER JOIN dbo.TI_ReportBaseSeasons ( NOLOCK ) Seasons
		ON  tkTrans.SEASON COLLATE Latin1_General_CS_AS = Seasons.Season COLLATE Latin1_General_CS_AS

	--LEFT OUTER JOIN dbo.TK_PTABLE_PRLEV tkPTablePRLev
	--on tkTransItem.SEASON = tkPTablePRLev.SEASON and tkItem.ptable = tkPTablePRLev.ptable
	--  and tkTransItemEvent.E_PL  = tkPTablePRLev.PL

	----- does the where clause apply to texas?
	WHERE tkTrans.SOURCE <> 'TK.ERES.SH.PURCHASE'
		AND (
				tkTrans.E_STAT NOT IN ('MI', 'MO', 'TO', 'TI', 'EO', 'EI')
				OR tkTrans.E_STAT IS NULL
			)
		AND tkTransItemPaymode.I_PAY_TYPE = 'I'
	GROUP BY   
		 tkTransItem.CUSTOMER
		,tkTransItem.ITEM
		,tkTransItemEvent.E_PL
		,tkTransItem.I_PT
		,tkTransItem.I_PRICE
		,tkTransItem.I_DAMT
		,tkTransItem.SEASON
	HAVING SUM(ISNULL(( tkTransItemPaymode.I_PAY_PAMT ), 0)) > 0;

	---- Build Report --------------------------------------------------------------------------------------------------

	CREATE TABLE #ReportBase (
		SEASON VARCHAR(15) COLLATE SQL_Latin1_General_CP1_CS_AS
	   ,CUSTOMER VARCHAR(20) COLLATE SQL_Latin1_General_CP1_CS_AS
	   ,CUSTOMER_TYPE VARCHAR(32)
	   ,ITEM VARCHAR(32) COLLATE SQL_Latin1_General_CP1_CS_AS
	   ,E_PL VARCHAR(10) COLLATE SQL_Latin1_General_CP1_CS_AS
	   ,I_PT VARCHAR(32) COLLATE SQL_Latin1_General_CP1_CS_AS
	   ,I_PRICE NUMERIC(18, 2)
	   ,I_DAMT NUMERIC(18, 2)
	   ,ORDQTY BIGINT
	   ,ORDTOTAL NUMERIC(18, 2)
	   ,PAIDCUSTOMER VARCHAR(20)
	   ,MINPAYMENTDATE DATETIME
	   ,PAIDTOTAL NUMERIC(18, 2)
	   ,INSERTDATE DATETIME
	);

	INSERT INTO #ReportBase (
		SEASON
	   ,CUSTOMER
	   ,CUSTOMER_TYPE
	   ,ITEM
	   ,E_PL
	   ,I_PT
	   ,I_PRICE
	   ,I_DAMT
	   ,ORDQTY
	   ,ORDTOTAL
	   ,PAIDCUSTOMER
	   ,MINPAYMENTDATE
	   ,PAIDTOTAL
	   ,INSERTDATE
	)
	SELECT
		 SalesBase.SEASON
		,SalesBase.CUSTOMER
		,tkCustomer.[TYPE] CUSTOMER_TYPE
		,SalesBase.ITEM
		,SalesBase.E_PL
		,SalesBase.I_PT
		,SalesBase.I_PRICE
		,SalesBase.I_DAMT
		,SalesBase.ORDQTY
		,SalesBase.ORDTOTAL
		,PaidFinal.CUSTOMER AS PAIDCUSTOMER
		,PaidFinal.MINPAYMENTDATE
		,ISNULL(PaidFinal.PAIDTOTAL, 0) PAIDTOTAL
		,GETDATE() INSERTDATE
	FROM #SalesBase SalesBase
	LEFT JOIN #PaidFinal PaidFinal
		ON  SalesBase.CUSTOMER = PaidFinal.CUSTOMER
		AND SalesBase.SEASON = PaidFinal.SEASON
		AND SalesBase.ITEM = PaidFinal.ITEM
		AND ISNULL(SalesBase.E_PL, 99999) = ISNULL(PaidFinal.E_PL, 99999)
		AND ISNULL(SalesBase.I_PT, 99999) = ISNULL(PaidFinal.I_PT, 99999)
		AND SalesBase.I_PRICE = PaidFinal.I_PRICE
		AND SalesBase.I_DAMT = PaidFinal.I_DAMT
	LEFT JOIN dbo.TK_CUSTOMER ( NOLOCK ) tkCustomer
		ON  SalesBase.CUSTOMER = tkCustomer.CUSTOMER COLLATE SQL_Latin1_General_CP1_CS_AS
	WHERE SalesBase.ORDQTY <> 0;

	SELECT *
	FROM #ReportBase;

END;










GO
