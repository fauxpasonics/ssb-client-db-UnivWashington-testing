CREATE TABLE [dbo].[ADV_ContactCustom]
(
[ContactID] [int] NOT NULL,
[ADNumber] [int] NULL,
[SetupDate] [datetime] NULL,
[Status] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AccountName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FirstName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MiddleInitial] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LastName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Company] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Salutation] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Email] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PHHome] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PHBusiness] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Ext] [char] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Fax] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Mobile] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PHOther1] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PHOther1Desc] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PHOther2] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PHOther2Desc] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Birthday] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TicketNumber] [int] NULL,
[TicketName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AlumniInfo] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SpouseName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SpouseBirthday] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SpouseAlumniInfo] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ChildrenNames] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CashBasisPP] [int] NULL,
[AccrualBasisPP] [int] NULL,
[AdjustedPP] [int] NULL,
[LastEdited] [datetime] NULL,
[EditedBy] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Program] [bit] NOT NULL,
[ProgramName] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Dear] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Zone] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BusinessTitle] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BankName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BankCity] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AccountNo] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RoutingNo] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LifetimeGiving] [money] NULL,
[UDF1] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UDF2] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UDF3] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UDF4] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UDF5] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BillingCycle] [int] NULL,
[EStatement] [bit] NOT NULL,
[FundraiserID] [int] NULL,
[LinkedAccount] [int] NULL,
[SSN] [varchar] (11) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Fundraiser] [bit] NULL,
[TeamID] [int] NULL,
[points1] [money] NULL,
[points2] [money] NULL,
[ActionNotes] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[StaffAssigned] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PPRank] [int] NULL,
[BillingMonth] [int] NULL,
[PledgeLevel] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[OverrideLevel] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ReceiptsLevel] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Suffix] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CON_Rank] [int] NULL,
[CON_Points] [decimal] (14, 4) NULL,
[FB_Rank] [int] NULL,
[FB_Points] [decimal] (14, 4) NULL,
[MBB_Rank] [int] NULL,
[MBB_Points] [decimal] (14, 4) NULL,
[WBB_Rank] [int] NULL,
[WBB_Points] [decimal] (14, 4) NULL,
[FBR_Rank] [int] NULL,
[FBR_Points] [decimal] (14, 4) NULL,
[WBBR_Rank] [int] NULL,
[WBBR_Points] [decimal] (14, 4) NULL,
[MBBR_Rank] [int] NULL,
[MBBR_Points] [decimal] (14, 4) NULL,
[Cash_Pts] [int] NULL,
[Accrual_Pts] [decimal] (14, 4) NULL,
[LifetimeICA] [money] NULL,
[ImageLink] [varchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PinNumber] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
ALTER TABLE [dbo].[ADV_ContactCustom] ADD CONSTRAINT [PK_Contact_ca32b400-99bb-469a-a2c6-0b8953502194] PRIMARY KEY CLUSTERED  ([ContactID])
GO
CREATE NONCLUSTERED INDEX [IX_AccountName] ON [dbo].[ADV_ContactCustom] ([AccountName])
GO
CREATE NONCLUSTERED INDEX [IX_ADNumber] ON [dbo].[ADV_ContactCustom] ([ADNumber])
GO
CREATE NONCLUSTERED INDEX [IX_Company] ON [dbo].[ADV_ContactCustom] ([Company])
GO
CREATE NONCLUSTERED INDEX [IX_FundRaiser_i_ContactID_AccountName] ON [dbo].[ADV_ContactCustom] ([ContactID], [AccountName], [Fundraiser])
GO
CREATE NONCLUSTERED INDEX [IX_AccountName_i_ContactID_ADNumber_Status] ON [dbo].[ADV_ContactCustom] ([ContactID], [ADNumber], [Status], [AccountName])
GO
CREATE NONCLUSTERED INDEX [IX_AccountNumber_i_ContactID_TicketNumber] ON [dbo].[ADV_ContactCustom] ([ContactID], [TicketNumber], [AccountName])
GO
CREATE NONCLUSTERED INDEX [IX_Email] ON [dbo].[ADV_ContactCustom] ([Email])
GO
CREATE NONCLUSTERED INDEX [IX_ContactID_FB_Points] ON [dbo].[ADV_ContactCustom] ([FB_Points], [ContactID])
GO
CREATE NONCLUSTERED INDEX [IX_FBRank] ON [dbo].[ADV_ContactCustom] ([FB_Rank])
GO
CREATE NONCLUSTERED INDEX [IX_ContactID_i_FBPoints] ON [dbo].[ADV_ContactCustom] ([FBR_Points], [ContactID])
GO
CREATE NONCLUSTERED INDEX [IX_LastNameFirstName] ON [dbo].[ADV_ContactCustom] ([LastName], [FirstName])
GO
CREATE NONCLUSTERED INDEX [IX_ContactID_i_MBBPoints] ON [dbo].[ADV_ContactCustom] ([MBB_Points], [ContactID])
GO
CREATE NONCLUSTERED INDEX [IX_Status] ON [dbo].[ADV_ContactCustom] ([Status])
GO
CREATE NONCLUSTERED INDEX [IX_TicketNumber] ON [dbo].[ADV_ContactCustom] ([TicketNumber])
GO
CREATE NONCLUSTERED INDEX [IX_WBBRank_i_WBBPoints] ON [dbo].[ADV_ContactCustom] ([WBB_Points], [WBB_Rank])
GO
CREATE NONCLUSTERED INDEX [IX_WBBRRank_WBBRPoints] ON [dbo].[ADV_ContactCustom] ([WBBR_Points], [WBBR_Rank])
GO
