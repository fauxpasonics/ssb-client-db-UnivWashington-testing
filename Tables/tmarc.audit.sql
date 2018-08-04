CREATE TABLE [tmarc].[audit]
(
[ETL__ID] [int] NOT NULL IDENTITY(1, 1),
[ETL__CreatedDate] [datetime] NOT NULL,
[ETL__Source] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[event_name] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[parent_price_code] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[price_code_Desc] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PLAN] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[event] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[groups] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[comp] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[held] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[avail] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[KILL] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[revenue] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[price_code] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AuditHostSold] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AuditArchticsSold] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TicketHostSold] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TicketArchticsSold] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TicketAvailSold] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DiffHostSold] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DiffArchticsSold] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[event_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[export_datetime] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[seq_num] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
