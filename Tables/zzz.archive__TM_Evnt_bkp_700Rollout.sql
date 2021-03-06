CREATE TABLE [zzz].[archive__TM_Evnt_bkp_700Rollout]
(
[event_name] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[event_date] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[event_time] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[event_day] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Team] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[plan_abv] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[event_report_group] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[plan_type] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Enabled] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Returnable] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Min_events] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[total_events] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FSE] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Dsps_allowed] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[exchange_price_opt] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Season_name] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[event_name_long] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Tm_event_name] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Event_sort] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Game_Numbe] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Barcode_Status] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Print_Ticket_Ind] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Add_date] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Upd_user] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Upd_date] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Event_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MaxEventDate] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Event_Type] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Arena_name] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Major_Category] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Minor_Category] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Org_Name] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Plan] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Season_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SourceFileName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CreatedDate] [datetime] NULL CONSTRAINT [DF__TM_Evnt__Created__17036CC0] DEFAULT (getdate())
)
WITH
(
DATA_COMPRESSION = PAGE
)
GO
CREATE NONCLUSTERED INDEX [IDX_CreatedDate] ON [zzz].[archive__TM_Evnt_bkp_700Rollout] ([CreatedDate])
GO
CREATE NONCLUSTERED INDEX [IDX_SourceFileName] ON [zzz].[archive__TM_Evnt_bkp_700Rollout] ([SourceFileName])
GO
