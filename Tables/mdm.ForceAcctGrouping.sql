CREATE TABLE [mdm].[ForceAcctGrouping]
(
[DimCustomerid] [int] NULL,
[GroupingID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CreatedDate] [datetime] NOT NULL CONSTRAINT [DF__ForceAcct__Creat__1FEC4B3A] DEFAULT (getdate()),
[UpdatedDate] [datetime] NOT NULL CONSTRAINT [DF__ForceAcct__Updat__20E06F73] DEFAULT (getdate()),
[CreatedBy] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ModifiedBy] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PriorGrouping] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
GRANT DELETE ON  [mdm].[ForceAcctGrouping] TO [db_SSB_IE_Permitted]
GO
GRANT INSERT ON  [mdm].[ForceAcctGrouping] TO [db_SSB_IE_Permitted]
GO
GRANT UPDATE ON  [mdm].[ForceAcctGrouping] TO [db_SSB_IE_Permitted]
GO
