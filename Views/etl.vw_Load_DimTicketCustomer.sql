SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE VIEW [etl].[vw_Load_DimTicketCustomer] AS (

	SELECT
		'TM' ETL__SourceSystem
		, CAST(c.acct_id AS NVARCHAR(25)) + ':' + CAST(c.cust_name_id AS NVARCHAR(25)) ETL__SSID
		--, p.PATRON ETL__SSID_PATRON --Paciolan
		, CAST(c.acct_id AS NVARCHAR(25)) AS [ETL__SSID_acct_id]
		, NULL DimRepId
		, CAST(CASE WHEN name_type = 'C' THEN 1 ELSE 0 END AS BIT) IsCompany
		, CAST(company_name AS NVARCHAR (50)) CompanyName
		, NULL FullName
		, NULL Prefix
		, c.name_first AS FirstName
		, c.name_mi AS MiddleName
		, LEFT(c.name_last,100) AS LastName
		, NULL Suffix
		, NULL TicketCustomerClass
		, NULL  [Status]
		, CAST(c.acct_id AS NVARCHAR(25)) CustomerId
		, NULL VIPCode
		, NULL IsVIP
		, NULL Tag
		, CAST(c.acct_type_desc AS NVARCHAR (50)) AccountType
		, NULL Keywords
		, NULL Gender
		, NULL AddDateTime
		, NULL SinceDate
		, NULL Birthday
		, c.email_addr AS Email
		, LEFT(c.phone_day,25) AS Phone
		, c.street_addr_1 AS AddressStreet1
		, c.street_addr_2 AS AddressStreet2
		, c.city AS AddressCity
		, c.state AddressState
		, c.zip AddressZip
		, c.country AddressCountry

	--SELECT top 1000 *
	FROM ods.TM_Cust c (NOLOCK)


)
GO
