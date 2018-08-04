SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




/**
7/23/2017 - adjusted criteria for UW - AMEITIN
7/31/2017 - adjusted donations criteria to only pull active accounts - AMEITIN

**/

 CREATE PROCEDURE [etl].[sp_CRMInteg_RecentCustData]
AS

TRUNCATE TABLE etl.CRMProcess_RecentCustData

DECLARE @Client VARCHAR(50)
SET @Client = 'UnivWashington' --updateme


SELECT x.dimcustomerid, MAX(x.maxtransdate) maxtransdate, x.team
INTO #tmpTicketSales
	FROM (
		--Ticketing
		SELECT dc.DimCustomerID, MAX(tk.I_Date) MaxTransDate , @Client Team
		--Select * 
		FROM dbo.TK_ODET tk WITH(NOLOCK)	
		JOIN dbo.DimCustomer dc (NOLOCK)
			on tk.Customer = dc.SSID and Sourcesystem = 'Paciolan'	
		WHERE tk.I_Date >= DATEADD(YEAR, -3, GETDATE())
		GROUP BY dc.[DimCustomerId]

		UNION ALL 

		--Athletic Donations
		SELECT dc.DimCustomerID, MAX(th.TransDate) MaxTransDate , @Client Team
		--Select * 
		FROM [dbo].[ADV_ContactTransHeader] th WITH(NOLOCK)	
		JOIN  dbo.DimCustomer dc (NOLOCK)
			on th.ContactId = dc.SSID and Sourcesystem = 'Advantage'	
		WHERE th.TransDate >= DATEADD(YEAR, -3, GETDATE())
		AND dc.CustomerStatus = 'Active' --added 7/31
		GROUP BY dc.[DimCustomerId]

		UNION ALL 

		--Adobe Tracking
		SELECT dc.DimCustomerID, MAX(tl.LogDate) MaxTransDate , @Client Team
		--Select * 
		FROM [ods].[Adobe_TrackingLog] tl WITH(NOLOCK)	
		JOIN  dbo.DimCustomer dc (NOLOCK) 
			on tl.AccountFK = dc.SSID and Sourcesystem = 'Adobe'	
		WHERE tl.LogDate >= DATEADD(Day, -90, GETDATE())
		GROUP BY dc.[DimCustomerId]

		UNION ALL 

		--Adobe Forms
		SELECT dc.DimCustomerID, MAX(fs.SubmitDate) MaxTransDate , @Client Team
		--Select * 
		FROM [ods].[Adobe_FormSubmit] fs WITH(NOLOCK)	
		JOIN  dbo.DimCustomer dc (NOLOCK)
			on fs.AccountPrimaryKey = dc.SSID and Sourcesystem = 'Adobe'	
		WHERE fs.SubmitDate >= DATEADD(Day, -90, GETDATE())
		GROUP BY dc.[DimCustomerId]


		) x
		GROUP BY x.dimcustomerid, x.team


INSERT INTO etl.CRMProcess_RecentCustData (dimcustomerid, SSID, MaxTransDate, Team)
SELECT a.dimcustomerid, SSID, [MaxTransDate], Team FROM [#tmpTicketSales] a 
INNER JOIN dbo.[vwDimCustomer_ModAcctId] b ON [b].[DimCustomerId] = [a].[DimCustomerId]



GO
