CREATE TABLE [zzz].[ods__TM_Evnt_bkp_700Rollout]
(
[id] [bigint] NOT NULL IDENTITY(1, 1),
[event_name] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[event_date] [datetime] NULL,
[event_time] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[event_day] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Team] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[plan_abv] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[event_report_group] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[plan_type] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Enabled] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Returnable] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Min_events] [int] NULL,
[total_events] [int] NULL,
[FSE] [decimal] (18, 6) NULL,
[Dsps_allowed] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[exchange_price_opt] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Season_name] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[event_name_long] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Tm_event_name] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Event_sort] [int] NULL,
[Game_Numbe] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Barcode_Status] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Print_Ticket_Ind] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Add_date] [datetime] NULL,
[Upd_user] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Upd_date] [datetime] NULL,
[Event_id] [int] NULL,
[MaxEventDate] [datetime] NULL,
[Event_Type] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Arena_name] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Major_Category] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Minor_Category] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Org_Name] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Plan] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Season_id] [int] NULL,
[InsertDate] [datetime] NULL CONSTRAINT [DF__TM_Evnt__InsertD__282DF8C2] DEFAULT (getdate()),
[UpdateDate] [datetime] NULL CONSTRAINT [DF__TM_Evnt__UpdateD__29221CFB] DEFAULT (getdate()),
[SourceFileName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[HashKey] [binary] (32) NULL
)
WITH
(
DATA_COMPRESSION = PAGE
)
GO
ALTER TABLE [zzz].[ods__TM_Evnt_bkp_700Rollout] ADD CONSTRAINT [PK__TM_Evnt__3213E83F134E117E] PRIMARY KEY CLUSTERED  ([id]) WITH (DATA_COMPRESSION = PAGE)
GO
