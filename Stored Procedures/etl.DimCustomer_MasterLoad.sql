SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO










CREATE PROCEDURE [etl].[DimCustomer_MasterLoad]

AS
BEGIN


-- TM (removed 7/10/2017 AMeitin)
--EXEC mdm.etl.LoadDimCustomer @ClientDB = 'UnivWashington', @LoadView = 'ods.vw_TM_LoadDimCustomer', @LogLevel = '0', @DropTemp = '1', @IsDataUploaderSource = '0'


-- Advantage (added 5/30/2017 AMeitin)
EXEC mdm.etl.LoadDimCustomer @ClientDB = 'UnivWashington', @LoadView = '[etl].[vw_Load_DimCustomer_Advantage]', @LogLevel = '0', @DropTemp = '1', @IsDataUploaderSource = '0'

-- Adobe (added 7/09/2017 SSales)
EXEC mdm.etl.LoadDimCustomer @ClientDB = 'UnivWashington', @LoadView = '[etl].[vw_Load_DimCustomer_Adobe]', @LogLevel = '0', @DropTemp = '1', @IsDataUploaderSource = '0'

-- Paciolan (added 7/10/2017 SSales)
EXEC mdm.etl.LoadDimCustomer @ClientDB = 'UnivWashington', @LoadView = '[etl].[vw_Load_DimCustomer_Paciolan]', @LogLevel = '0', @DropTemp = '1', @IsDataUploaderSource = '0'

-- SFDC (added 8/3/2017 AMeitin)
EXEC mdm.etl.LoadDimCustomer @ClientDB = 'UnivWashington', @LoadView = '[etl].[vw_Load_DimCustomer_SFDCAccount]', @LogLevel = '0', @DropTemp = '1', @IsDataUploaderSource = '0'

--SFDC deletes
UPDATE b
	SET b.IsDeleted = a.IsDeleted
	,deletedate = GETDATE()
	--SELECT a.IsDeleted
	--SELECT COUNT(*) 
	FROM UnivWashington_Reporting.ProdCopy.Account a (NOLOCK)
	INNER JOIN dbo.DimCustomer b (NOLOCK) ON a.id = b.SSID AND b.SourceSystem = 'UW PC_SFDC Account'
	WHERE a.IsDeleted <> b.IsDeleted

--Paciolan deletes (added 12/14/2017 by AMEITIN)
UPDATE dc
	SET IsDeleted = '1'
	, DeleteDate = GETUTCDATE()
	--SELECT * 
	FROM dbo.DimCustomer dc (NOLOCK)
	LEFT JOIN (select DISTINCT PATRON
				FROM dbo.PD_PATRON (NOLOCK)) p on dc.SourceSystem = 'Paciolan' AND dc.SSID = p.PATRON
	WHERE p.PATRON IS NULL
	AND SourceSystem = 'Paciolan'
	AND dc.IsDeleted = '0'

END






GO
