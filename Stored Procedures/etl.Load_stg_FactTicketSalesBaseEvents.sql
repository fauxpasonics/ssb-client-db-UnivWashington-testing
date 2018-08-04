SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/***** Revision History
 
 Jeff Barberio on 2018-07-26: Adjusted "ORDTOTAL" to include fees and surcharge, adjusted pay_mode filters to pick up fees/surcharge
, Reviewed By: Zach Frick on 2018-07-26

*****/
 
CREATE   PROCEDURE [etl].[Load_stg_FactTicketSalesBaseEvents]
AS

BEGIN
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	 -- Create #SalesBase --------------------------------------------------------------------------------------------------
	IF OBJECT_ID('tempdb..#SalesBase') IS NOT NULL
		DROP TABLE #SalesBase
	CREATE TABLE #SalesBase (
		 SEASON VARCHAR(15) COLLATE SQL_Latin1_General_CP1_CS_AS
		,CUSTOMER VARCHAR(20) COLLATE SQL_Latin1_General_CP1_CS_AS
		,ITEM VARCHAR(32) COLLATE SQL_Latin1_General_CP1_CS_AS
		,EVENT VARCHAR(32) COLLATE SQL_Latin1_General_CP1_CS_AS
		,DATE DATETIME --ADDED 1/2/2018 FOR TESTING PURPOSES
		,TRANS_NO BIGINT --ADDED 1/2/2018 FOR TESTING PURPOSES
		,E_PL VARCHAR(10) COLLATE SQL_Latin1_General_CP1_CS_AS
		,E_PT VARCHAR(32) COLLATE SQL_Latin1_General_CP1_CS_AS
		,E_PRICE NUMERIC(18, 2)
		,E_DAMT NUMERIC(18, 2)
		,E_STAT VARCHAR(MAX) COLLATE SQL_Latin1_General_CP1_CS_AS
		,ORDQTY BIGINT
		,ORDTOTAL NUMERIC(18, 2)
		,ORDFEE NUMERIC(18, 2)
		,OrderConvenienceFee NUMERIC(18, 2)
		,SoftDelete BIT DEFAULT(0)
	);
	INSERT INTO #SalesBase (
		 SEASON
		,CUSTOMER
		,ITEM
		,EVENT
		,DATE --ADDED 1/2/2018 FOR TESTING PURPOSES
		,TRANS_NO --ADDED 1/2/2018 FOR TESTING PURPOSES
		,E_PL
		,E_PT
		,E_PRICE
		,E_DAMT
		,E_STAT
		,ORDQTY
		,ORDTOTAL
		,ORDFEE
		,OrderConvenienceFee
	)
	SELECT
		 tkTrans.SEASON
		,tkTransItem.CUSTOMER
		,tkTransItem.ITEM
		,tkTransItemEvent.EVENT
		,MIN(tkTrans.DATE) AS DATE --ADDED 1/2/2018 FOR TESTING PURPOSES
		,tkTrans.TRANS_NO --ADDED 1/2/2018 FOR TESTING PURPOSES
		,tkTransItemEvent.E_PL
		,tkTransItemEvent.E_PT
		,tkTransItemEvent.E_PRICE
		,tkTransItemEvent.E_DAMT
		,tkTrans.E_STAT
		,SUM(ISNULL(tkTransItemEvent.E_OQTY_TOT, 0)) ORDQTY
		,SUM(ISNULL(tkTransItemEvent.E_OQTY_TOT, 0) * (ISNULL(tkTransItemEvent.E_PRICE, 0) - ISNULL(E_DAMT, 0) + ISNULL(tkTransItemEvent.E_FPRICE, 0) + ISNULL(tkTransItemEvent.E_CPRICE, 0))) AS ORDTOTAL --JBarberio 2018-07-26 Added in CPRICE to include Fees
		,SUM(ISNULL(tkTransItemEvent.E_OQTY_TOT, 0) * (ISNULL(tkTransItemEvent.E_FPRICE, 0))) AS ORDFEE
		,SUM(ISNULL(tkTransItemEvent.E_OQTY_TOT, 0) * (ISNULL(tkTransItemEvent.E_CPRICE, 0))) AS OrderConvenienceFee
	FROM dbo.TK_TRANS (NOLOCK) tkTrans
	INNER JOIN dbo.TK_TRANS_ITEM (NOLOCK) tkTransItem
		ON  tkTrans.SEASON COLLATE SQL_Latin1_General_CP1_CS_AS = tkTransItem.SEASON COLLATE SQL_Latin1_General_CP1_CS_AS
		AND tkTrans.TRANS_NO = tkTransItem.TRANS_NO
	LEFT JOIN (
			SELECT
				 subtkTransItemEvent.SEASON
				,MAX(ISNULL(subtkTransItemEvent.E_PL, 99999)) E_PL
				,subtkTransItemEvent.TRANS_NO
				,subtkTransItemEvent.VMC
				,subtkTransItemEvent.EVENT
				,subtkTransItemEvent.E_OQTY_TOT
				,subtkTransItemEvent.E_PRICE
				,subtkTransItemEvent.E_DAMT
				,subtkTransItemEvent.E_PT
				,subtkTransItemEvent.E_FPRICE
				,subtkTransItemEvent.E_CPRICE
			FROM dbo.TK_TRANS_ITEM_EVENT (NOLOCK) subtkTransItemEvent
			GROUP BY
				 subtkTransItemEvent.SEASON
				,subtkTransItemEvent.TRANS_NO
				,subtkTransItemEvent.VMC
				,subtkTransItemEvent.EVENT
				,subtkTransItemEvent.E_OQTY_TOT
				,subtkTransItemEvent.E_PRICE
				,subtkTransItemEvent.E_DAMT
				,subtkTransItemEvent.E_PT
				,subtkTransItemEvent.E_FPRICE
				,subtkTransItemEvent.E_CPRICE
		) tkTransItemEvent
		ON  tkTransItem.SEASON = tkTransItemEvent.SEASON
		AND	tkTransItem.TRANS_NO = tkTransItemEvent.TRANS_NO
		AND	tkTransItem.VMC = tkTransItemEvent.VMC
	INNER JOIN dbo.TK_ITEM (NOLOCK) tkItem
		ON  tkTransItem.SEASON COLLATE SQL_Latin1_General_CP1_CS_AS = tkItem.SEASON COLLATE SQL_Latin1_General_CP1_CS_AS
		AND tkTransItem.ITEM COLLATE SQL_Latin1_General_CP1_CS_AS = tkItem.ITEM COLLATE SQL_Latin1_General_CP1_CS_AS
	WHERE tkTrans.SOURCE <> 'TK.ERES.SH.PURCHASE'
		AND (
				tkTrans.E_STAT NOT IN (	'MI', 'MO', 'TO', 'TI', 'EO', 'EO R', 'EI')
				OR tkTrans.E_STAT IS NULL
			)
		AND NOT (
				tkTransItem.ITEM = 'FSN'
				AND ISNULL(tkTrans.E_STAT, '') = 'R'
			)
	GROUP BY
		 tkTrans.SEASON
		,tkTransItem.CUSTOMER
		,tkTransItem.ITEM
		,tkTransItemEvent.EVENT
		,tkTrans.TRANS_NO --ADDED 1/2/2018 FOR TESTING PURPOSES
		,tkTransItemEvent.E_PL
		,tkTransItemEvent.E_PT
		,tkTransItemEvent.E_PRICE
		,tkTransItemEvent.E_DAMT
		,tkTrans.E_STAT;

	IF OBJECT_ID('tempdb..#SalesBase_Filter') IS NOT NULL
		DROP TABLE #SalesBase_Filter
	SELECT
		 SEASON
		,CUSTOMER
		,ITEM
		,EVENT
		,E_PL
		,E_PT
		,E_PRICE
		,E_DAMT
		,E_STAT
		,SUM(ORDQTY) AS ORDQTY
		,SUM(ORDTOTAL) AS ORDTOTAL
		,SUM(ORDFEE) AS ORDFEE
		,SUM(OrderConvenienceFee) AS OrderConvenienceFee
	INTO #SalesBase_Filter
	FROM #SalesBase
	GROUP BY
		 SEASON
		,CUSTOMER
		,ITEM
		,EVENT
		,E_PL
		,E_PT
		,E_PRICE
		,E_DAMT
		,E_STAT
	HAVING SUM(ORDQTY) = 0

	UPDATE sb
	SET sb.SoftDelete = 1
	--SELECT *
	FROM #SalesBase sb
	INNER JOIN #SalesBase_Filter f
		ON  sb.CUSTOMER = f.CUSTOMER
		AND	sb.SEASON = f.SEASON
		AND	sb.ITEM = f.ITEM
		AND	ISNULL(sb.EVENT, '') = ISNULL(f.EVENT, '')
		AND	ISNULL(sb.E_PL, 99) = ISNULL(f.E_PL, 99)
		AND	ISNULL(sb.E_PT, 99) = ISNULL(f.E_PT, 99)
		AND	sb.E_PRICE = f.E_PRICE

	 -- Create #PaidFinal --------------------------------------------------------------------------------------------------
	IF OBJECT_ID('tempdb..#PaidFinal') IS NOT NULL
		DROP TABLE #PaidFinal
	CREATE TABLE #PaidFinal (
		 CUSTOMER VARCHAR(20) COLLATE SQL_Latin1_General_CP1_CS_AS
		,MINPAYMENTDATE DATETIME
		,EVENT VARCHAR(32) COLLATE SQL_Latin1_General_CP1_CS_AS
		,ITEM VARCHAR(32) COLLATE SQL_Latin1_General_CP1_CS_AS
		,TRANS_NO BIGINT --ADDED 1/2/2018 FOR TESTING PURPOSES
		,E_PL VARCHAR(10) COLLATE SQL_Latin1_General_CP1_CS_AS
		,E_PT VARCHAR(32) COLLATE SQL_Latin1_General_CP1_CS_AS
		,E_PRICE NUMERIC(18, 2)
		,PAIDTOTAL NUMERIC(18, 2)
		,SEASON VARCHAR(15) COLLATE SQL_Latin1_General_CP1_CS_AS
		,SoftDelete BIT DEFAULT(0)
	);
	INSERT INTO	#PaidFinal (
		 CUSTOMER
		,MINPAYMENTDATE
		,EVENT
		,ITEM
		,TRANS_NO
		,E_PL
		,E_PT
		,E_PRICE
		,PAIDTOTAL
		,SEASON
	)
	SELECT
		 tkTransItem.CUSTOMER
		,MIN(tkTrans.DATE) minPaymentDate
		,tkTransItemEvent.EVENT
		,tkTransItem.ITEM
		,tkTrans.TRANS_NO --ADDED 1/2/2018 FOR TESTING PURPOSES
		,tkTransItemEvent.E_PL
		,tkTransItemEvent.E_PT
		,tkTransItemEvent.E_PRICE
		,SUM(ISNULL((tkTransItemPaymode.E_PAY_PAMT), 0)) PAIDTOTAL
		,tkTransItem.SEASON
	FROM dbo.TK_TRANS (NOLOCK) tkTrans
	INNER JOIN dbo.TK_TRANS_ITEM (NOLOCK) tkTransItem
		ON  tkTrans.SEASON = tkTransItem.SEASON
		AND tkTrans.TRANS_NO = tkTransItem.TRANS_NO
	LEFT JOIN (
			SELECT
				 subtkTransItemEvent.SEASON
				,MAX(ISNULL(subtkTransItemEvent.E_PL, 99999)) E_PL
				,subtkTransItemEvent.TRANS_NO
				,subtkTransItemEvent.VMC
				,subtkTransItemEvent.SVMC
				,subtkTransItemEvent.E_PT
				,subtkTransItemEvent.E_PRICE
				,subtkTransItemEvent.[EVENT]
			FROM dbo.TK_TRANS_ITEM_EVENT (NOLOCK) subtkTransItemEvent
			WHERE ISNULL(subtkTransItemEvent.E_STAT, '') <> 'R'
			GROUP BY
				 subtkTransItemEvent.SEASON
				,subtkTransItemEvent.TRANS_NO
				,subtkTransItemEvent.VMC
				,subtkTransItemEvent.SVMC
				,subtkTransItemEvent.E_PT
				,subtkTransItemEvent.E_PRICE
				,subtkTransItemEvent.[EVENT]
		) tkTransItemEvent
		ON  tkTransItem.SEASON = tkTransItemEvent.SEASON
		AND	tkTransItem.TRANS_NO = tkTransItemEvent.TRANS_NO
		AND	tkTransItem.VMC = tkTransItemEvent.VMC
	INNER JOIN dbo.TK_TRANS_ITEM_EVENT_PAYMODE (NOLOCK) tkTransItemPaymode
		ON  tkTransItem.SEASON = tkTransItemPaymode.SEASON
		AND tkTransItem.TRANS_NO = tkTransItemPaymode.TRANS_NO
		AND tkTransItem.VMC = tkTransItemPaymode.VMC
		AND tkTransItemPaymode.SVMC = tkTransItemEvent.SVMC
	INNER JOIN dbo.TK_ITEM (NOLOCK) tkItem
		ON  tkTransItem.SEASON = tkItem.SEASON
		AND tkTransItem.ITEM = tkItem.ITEM
	LEFT OUTER JOIN	dbo.TK_PTABLE_PRLEV (NOLOCK) tkPTablePRLev
		ON  tkTransItem.SEASON = tkPTablePRLev.SEASON
		AND tkItem.PTABLE = tkPTablePRLev.PTABLE
		AND tkTransItemEvent.E_PL = tkPTablePRLev.PL
	WHERE (
			ISNULL(tkTrans.E_STAT, 0) NOT IN ('MI', 'MO', 'TO', 'TI', 'EO', 'EO R', 'EI')
				OR tkTrans.E_STAT IS NULL
			)
		AND tkTransItemPaymode.E_PAY_TYPE IN ('E', 'F', 'C') --JBarberio 2018-07-26 Added Types F and C for fees/surcharge
	GROUP BY 
		 tkTransItem.CUSTOMER
		,tkTransItem.ITEM
		,tkTrans.TRANS_NO --ADDED 1/2/2018 FOR TESTING PURPOSES
		,tkTransItemEvent.E_PL
		,tkTransItemEvent.E_PT
		,tkTransItemEvent.E_PRICE
		,tkTransItem.SEASON
		,tkTransItemEvent.EVENT

	UPDATE pf
	SET SoftDelete = 1
	FROM #PaidFinal pf
	INNER JOIN (
			SELECT 
				 CUSTOMER
				,MIN(MINPAYMENTDATE) AS MINPAYMENTDATE
				,EVENT
				,ITEM
				,E_PL
				,E_PT
				,E_PRICE
				,SUM(ISNULL(PAIDTOTAL, 0)) AS PAIDTOTAL
				,SEASON
			FROM #PaidFinal
			GROUP BY
				 CUSTOMER
				,EVENT
				,ITEM
				,E_PL
				,E_PT
				,E_PRICE
				,SEASON
			HAVING SUM(ISNULL(PAIDTOTAL, 0)) <=0
		) b
		ON  pf.CUSTOMER = b.CUSTOMER
		AND pf.SEASON = b.SEASON
		AND pf.EVENT = b.EVENT
		AND	ISNULL(pf.ITEM, '') = ISNULL(b.ITEM, '')
		AND	ISNULL(pf.E_PL, 99) = ISNULL(b.E_PL, 99)
		AND	ISNULL(pf.E_PT, 99) = ISNULL(b.E_PT, 99)
		AND pf.E_PRICE = b.E_PRICE

	 ---- Build Report --------------------------------------------------------------------------------------------------
	IF OBJECT_ID('tempdb..#ReportBase_A') IS NOT NULL
		DROP TABLE #ReportBase_A
	CREATE TABLE #ReportBase_A (
		 ReportBaseId INT IDENTITY(1,1)
		,SEASON VARCHAR(15) COLLATE SQL_Latin1_General_CP1_CS_AS
		,CUSTOMER VARCHAR(20) COLLATE SQL_Latin1_General_CP1_CS_AS
		--,TRANS_NO BIGINT --ADDED 1/2/2018 FOR TESTING PURPOSES
		,ITEM VARCHAR(32) COLLATE SQL_Latin1_General_CP1_CS_AS
		,EVENT VARCHAR(32) COLLATE SQL_Latin1_General_CP1_CS_AS
		,E_PL VARCHAR(10) COLLATE SQL_Latin1_General_CP1_CS_AS
		,E_PT VARCHAR(32) COLLATE SQL_Latin1_General_CP1_CS_AS
		,E_PRICE NUMERIC(18, 2)
		,E_DAMT NUMERIC(18, 2)
		,E_STAT VARCHAR(MAX) COLLATE SQL_Latin1_General_CP1_CS_AS
		,ORDQTY BIGINT
		,ORDTOTAL NUMERIC(18, 2)
		,ORDFEE NUMERIC(18, 2)
		,OrderConvenienceFee NUMERIC(18, 2)
		,PAIDCUSTOMER VARCHAR(20)
		,MINPAYMENTDATE DATETIME
		,ORDERDATE DATETIME
		,PAIDTOTAL NUMERIC(18, 2)
		,SoftDelete BIT DEFAULT(0)
		,GroupNumber INT DEFAULT(0)
		,PaymentCount INT DEFAULT(0)
	);
	INSERT INTO	#ReportBase_A (
		 SEASON
		,CUSTOMER
		--,TRANS_NO --ADDED 1/2/2018 FOR TESTING PURPOSES
		,ITEM
		,[EVENT]
		,E_PL
		,E_PT
		,E_PRICE
		,E_DAMT
		,E_STAT
		,ORDQTY
		,ORDTOTAL
		,ORDFEE
		,OrderConvenienceFee
		,PAIDCUSTOMER
		,MINPAYMENTDATE
		,ORDERDATE --ADDED 1/2/2018 FOR TESTING PURPOSES
		,PAIDTOTAL
	)
	SELECT
		 SalesBase.SEASON
		,SalesBase.CUSTOMER
		--,SalesBase.TRANS_NO --ADDED 1/2/2018 FOR TESTING PURPOSES
		,SalesBase.ITEM
		,SalesBase.[EVENT]
		,SalesBase.E_PL
		,SalesBase.E_PT
		,SalesBase.E_PRICE
		,SalesBase.E_DAMT
		,SalesBase.E_STAT
		--,NULL AS E_STAT
		,SUM(SalesBase.ORDQTY) AS ORDQTY
		,SUM(SalesBase.ORDTOTAL) AS ORDTOTAL
		,SUM(SalesBase.ORDFEE) AS ORDFEE
		,SUM(OrderConvenienceFee) AS OrderConvenienceFee
		,PaidFinal.CUSTOMER AS PAIDCUSTOMER
		,PaidFinal.MINPAYMENTDATE AS MINPAYMENTDATE
		,SalesBase.DATE AS ORDERDATE
		,SUM(ISNULL(PaidFinal.PAIDTOTAL, 0)) PAIDTOTAL
	FROM #SalesBase SalesBase
	LEFT JOIN #PaidFinal PaidFinal
		ON  SalesBase.CUSTOMER = PaidFinal.CUSTOMER
		AND	SalesBase.SEASON = PaidFinal.SEASON
		AND SALESBASE.TRANS_NO = PaidFinal.TRANS_NO
		AND	SalesBase.ITEM = PaidFinal.ITEM
		AND	ISNULL(PaidFinal.EVENT, '') = ISNULL(SalesBase.EVENT, '')
		AND	ISNULL(SalesBase.E_PL, 99) = ISNULL(PaidFinal.E_PL, 99)
		AND	ISNULL(SalesBase.E_PT, 99) = ISNULL(PaidFinal.E_PT, 99)
		AND	SalesBase.E_PRICE = PaidFinal.E_PRICE
		AND PaidFinal.SoftDelete = 0
	GROUP BY
		 SalesBase.SEASON
		,SalesBase.CUSTOMER
		--,SalesBase.TRANS_NO --ADDED 1/2/2018 FOR TESTING PURPOSES
		,SalesBase.ITEM
		,SalesBase.[EVENT]
		,SalesBase.E_PL
		,SalesBase.E_PT
		,SalesBase.E_PRICE
		,SalesBase.E_DAMT
		,SalesBase.E_STAT
		,PaidFinal.CUSTOMER
		,PaidFinal.MINPAYMENTDATE
		,SalesBase.DATE
	
	UPDATE rb
	SET SoftDelete = 1
	--SELECT rb.*
	FROM #ReportBase_A rb
	INNER JOIN #SalesBase_Filter f
		ON  rb.CUSTOMER = f.CUSTOMER
		AND	rb.SEASON = f.SEASON
		AND	rb.ITEM = f.ITEM
		AND	ISNULL(rb.EVENT, '') = ISNULL(f.EVENT, '')
		AND	ISNULL(rb.E_PL, 99) = ISNULL(f.E_PL, 99)
		AND	ISNULL(rb.E_PT, 99) = ISNULL(f.E_PT, 99)
		AND	ISNULL(rb.E_PRICE, 99) = ISNULL(f.E_PRICE, 99)
		AND	ISNULL(rb.E_DAMT, 99) = ISNULL(f.E_DAMT, 99)
		AND ISNULL(rb.E_STAT, '') = ISNULL(f.E_STAT, '')

	UPDATE rb
	SET SoftDelete = 1
	--SELECT * 
	FROM #ReportBase_A rb
	WHERE SoftDelete = 0
		AND OrdQty = 0
		AND OrdTotal = 0
		AND ISNULL(OrderConvenienceFee, 0) = 0
		AND MINPAYMENTDATE IS NULL
		AND ISNULL(PAIDTOTAL, 0) = 0

	UPDATE rb
	SET GroupNumber = b.GroupNumber
	FROM #ReportBase_A rb
	INNER JOIN (
			SELECT 
				 rb.CUSTOMER
				,rb.SEASON
				,rb.ITEM
				,ISNULL(rb.EVENT, '') AS Event
				,ISNULL(rb.E_PL, 99) AS E_PL
				,ISNULL(rb.E_PT, 99) AS E_PT
				,ISNULL(rb.E_PRICE, 99) AS E_PRICE
				,ISNULL(rb.E_DAMT, 99) AS E_DAMT
				,ISNULL(rb.E_STAT, '') AS E_STAT
				,rb.PAIDCUSTOMER
				,rb.MINPAYMENTDATE
				,DENSE_RANK() OVER (
						PARTITION BY 
							 rb.CUSTOMER
							,rb.SEASON
							,rb.ITEM
							,ISNULL(rb.EVENT, '')
						ORDER BY
							 rb.CUSTOMER
							,rb.SEASON
							,rb.ITEM
							,ISNULL(rb.EVENT, '')
							,ISNULL(rb.E_PL, 99)
							,ISNULL(rb.E_PT, 99)
							,ISNULL(rb.E_PRICE, 99)
							,ISNULL(rb.E_DAMT, 99)
							,ISNULL(rb.E_STAT, '')
						) AS GroupNumber
			FROM #ReportBase_A rb
			--WHERE SEASON = 'VB17' AND CUSTOMER = 20799 AND ITEM = 'VB11' 
		) b
		ON  rb.CUSTOMER = b.CUSTOMER
		AND rb.SEASON = b.SEASON
		AND rb.ITEM = b.ITEM
		AND ISNULL(rb.EVENT, '') = b.EVENT
		AND ISNULL(rb.E_PL, 99) = b.E_PL
		AND ISNULL(rb.E_PT, 99) = b.E_PT
		AND ISNULL(rb.E_PRICE, 99) = b.E_PRICE
		AND ISNULL(rb.E_DAMT, 99) = b.E_DAMT
		AND ISNULL(rb.E_STAT, '') = b.E_STAT

	UPDATE rb
	SET PaymentCount = b.PaymentCount
	FROM #ReportBase_A rb
	INNER JOIN (
			SELECT 
				 rb.CUSTOMER
				,rb.SEASON
				,rb.ITEM
				,ISNULL(rb.EVENT, '') AS Event
				,ISNULL(rb.E_PL, 99) AS E_PL
				,ISNULL(rb.E_PT, 99) AS E_PT
				,ISNULL(rb.E_PRICE, 99) AS E_PRICE
				,ISNULL(rb.E_DAMT, 99) AS E_DAMT
				,ISNULL(rb.E_STAT, '') AS E_STAT
				,rb.GroupNumber
				,COUNT(PAIDCUSTOMER) AS PaymentCount
			FROM #ReportBase_A rb
			GROUP BY 
				 rb.CUSTOMER
				,rb.SEASON
				,rb.ITEM
				,ISNULL(rb.EVENT, '')
				,ISNULL(rb.E_PL, 99)
				,ISNULL(rb.E_PT, 99)
				,ISNULL(rb.E_PRICE, 99)
				,ISNULL(rb.E_DAMT, 99)
				,ISNULL(rb.E_STAT, '')
				,rb.GroupNumber
		) b
		ON  rb.CUSTOMER = b.CUSTOMER
		AND rb.SEASON = b.SEASON
		AND rb.ITEM = b.ITEM
		AND ISNULL(rb.EVENT, '') = b.EVENT
		AND ISNULL(rb.E_PL, 99) = b.E_PL
		AND ISNULL(rb.E_PT, 99) = b.E_PT
		AND ISNULL(rb.E_PRICE, 99) = b.E_PRICE
		AND ISNULL(rb.E_DAMT, 99) = b.E_DAMT
		AND ISNULL(rb.E_STAT, '') = b.E_STAT
		AND rb.GroupNumber = b.GroupNumber

	IF OBJECT_ID('tempdb..#ReportBase') IS NOT NULL
		DROP TABLE #ReportBase
	CREATE TABLE #ReportBase (
		 SEASON VARCHAR(15) COLLATE SQL_Latin1_General_CP1_CS_AS
		,CUSTOMER VARCHAR(20) COLLATE SQL_Latin1_General_CP1_CS_AS
		,ITEM VARCHAR(32) COLLATE SQL_Latin1_General_CP1_CS_AS
		,EVENT VARCHAR(32) COLLATE SQL_Latin1_General_CP1_CS_AS
		,E_PL VARCHAR(10) COLLATE SQL_Latin1_General_CP1_CS_AS
		,E_PT VARCHAR(32) COLLATE SQL_Latin1_General_CP1_CS_AS
		,E_PRICE NUMERIC(18, 2)
		,E_DAMT NUMERIC(18, 2)
		,E_STAT VARCHAR(MAX) COLLATE SQL_Latin1_General_CP1_CS_AS
		,ORDQTY BIGINT
		,ORDTOTAL NUMERIC(18, 2)
		,ORDFEE NUMERIC(18, 2)
		,OrderConvenienceFee NUMERIC(18, 2)
		,PAIDCUSTOMER VARCHAR(20)
		,MINPAYMENTDATE DATETIME
		,ORDERDATE DATETIME
		,COMBINEDDATE DATETIME
		,PAIDTOTAL NUMERIC(18, 2)
	);
	INSERT INTO #ReportBase (
		 SEASON
		,CUSTOMER
		,ITEM
		,EVENT
		,E_PL
		,E_PT
		,E_PRICE
		,E_DAMT
		,E_STAT
		,ORDQTY
		,ORDTOTAL
		,ORDFEE
		,OrderConvenienceFee
		,PAIDCUSTOMER
		,MINPAYMENTDATE
		,ORDERDATE
		,COMBINEDDATE
		,PAIDTOTAL
	)
	SELECT 
		 rb.SEASON
		,rb.CUSTOMER
		,rb.ITEM
		,rb.EVENT
		,rb.E_PL
		,rb.E_PT
		,rb.E_PRICE
		,rb.E_DAMT
		,rb.E_STAT
		,SUM(rb.ORDQTY) AS ORDQTY
		,SUM(rb.ORDTOTAL) AS ORDTOTAL
		,SUM(rb.ORDFEE) AS ORDFEE
		,SUM(rb.OrderConvenienceFee) AS OrderConvenienceFee
		,MIN(rb.PAIDCUSTOMER) AS PAIDCUSTOMER
		,MIN(rb.MINPAYMENTDATE) AS MINPAYMENTDATE
		,MIN(rb.ORDERDATE) AS ORDERDATE
		,COALESCE(MIN(rb.MINPAYMENTDATE), MIN(rb.ORDERDATE)) AS COMBINEDDATE
		,SUM(rb.PAIDTOTAL) AS PAIDTOTAL
	FROM (
			SELECT
				 rb.SEASON
				,rb.CUSTOMER
				,rb.ITEM
				,rb.EVENT
				,rb.E_PL
				,rb.E_PT
				,rb.E_PRICE
				,rb.E_DAMT
				,rb.E_STAT
				,SUM(rb.ORDQTY) AS ORDQTY
				,SUM(rb.ORDTOTAL) AS ORDTOTAL
				,SUM(rb.ORDFEE) AS ORDFEE
				,SUM(rb.OrderConvenienceFee) AS OrderConvenienceFee
				,MIN(rb.PAIDCUSTOMER) AS PAIDCUSTOMER
				,COALESCE(MIN(rb.MINPAYMENTDATE), MIN(rb.ORDERDATE)) AS COMBINEDDATE
				,MIN(rb.MINPAYMENTDATE) AS MINPAYMENTDATE
				,MIN(rb.ORDERDATE) AS ORDERDATE
				,SUM(rb.PAIDTOTAL) AS PAIDTOTAL
			FROM #ReportBase_A rb
			WHERE rb.SoftDelete = 0
			GROUP BY
				 rb.SEASON
				,rb.CUSTOMER
				,rb.ITEM
				,rb.EVENT
				,rb.E_PL
				,rb.E_PT
				,rb.E_PRICE
				,rb.E_DAMT
				,rb.E_STAT
				,rb.GroupNumber
				,CASE WHEN PaymentCount = 0 THEN ReportBaseId ELSE rb.GroupNumber END
		) rb
	GROUP BY
		 rb.SEASON
		,rb.CUSTOMER
		,rb.ITEM
		,rb.EVENT
		,rb.E_PL
		,rb.E_PT
		,rb.E_PRICE
		,rb.E_DAMT
		,rb.E_STAT
	HAVING 
		SUM(rb.ORDQTY) + SUM(rb.ORDTOTAL) + SUM(rb.ORDFEE) + SUM(rb.OrderConvenienceFee) + SUM(rb.PAIDTOTAL) <> 0

	TRUNCATE TABLE stg.FactTicketSalesBase;
	INSERT INTO	stg.FactTicketSalesBase (
		 SEASON
		,CUSTOMER
		,ITEM
		,EVENT
		,E_PL
		,E_PT
		,E_PRICE
		,E_DAMT
		,E_STAT
		,ORDQTY
		,ORDTOTAL
		,ORDFEE
		,OrderConvenienceFee
		,PAIDCUSTOMER
		,ORDERDATE
		,MINPAYMENTDATE
		,PAIDTOTAL
	)
	SELECT
		 rb.SEASON
		,rb.CUSTOMER
		,rb.ITEM
		,rb.EVENT
		,rb.E_PL
		,rb.E_PT
		,rb.E_PRICE
		,rb.E_DAMT
		,rb.E_STAT
		,rb.ORDQTY
		,rb.ORDTOTAL
		,rb.ORDFEE
		,rb.OrderConvenienceFee
		,rb.PAIDCUSTOMER
		,rb.ORDERDATE
		,rb.MINPAYMENTDATE
		,rb.PAIDTOTAL
	FROM #ReportBase rb;

	ALTER INDEX ALL	ON stg.FactTicketSalesBase REBUILD;
END;
GO
