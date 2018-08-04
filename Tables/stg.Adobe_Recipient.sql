CREATE TABLE [stg].[Adobe_Recipient]
(
[ETL_ID] [int] NOT NULL IDENTITY(1, 1),
[ETL_CreatedDate] [datetime] NOT NULL CONSTRAINT [DF__Adobe_Rec__ETL_C__71C268D9] DEFAULT (getdate()),
[ETL_FileName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PrimaryKey] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AccountId] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AccountType] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Address1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Address2] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Address3] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Baseball_Preferences] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BirthdayDay_Preferences] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BirthdayMonth_Preferences] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BusinessPhone] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[City] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Company] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CreationDate] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CreationDate_Preferences] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Email] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EmailOptOut_Preferences] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FirstName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Football_Preferences] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Golf_Preferences] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[GroupPackages_Preferences] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Guid] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Gymnastics_Preferences] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[HomePhone] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[InternetProfile] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LastModified] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LastModified_Preferences] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LastName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Linked] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LinkedEmail] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MensBasketball_Preferences] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MensSoccer_Preferences] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MobilePhone] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PartialPlans_Preferences] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PIN] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Promotions_Preferences] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Rowing_Preferences] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SeasonTickets_Preferences] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SingleGameTickets_Preferences] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Softball_Preferences] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SpecialEvents_Preferences] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Status] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[StubhubEmail] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Tennis_Preferences] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TrackFieldCross_Preferences] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UniversityEmail] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Volleyball_Preferences] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[WomensBasketball_Preferences] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[WomensSoccer_Preferences] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Zip] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ADNumber] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ContactID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BirthdayYear_Preferences] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
