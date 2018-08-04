CREATE TABLE [stg].[TicketBase]
(
[season_year] [int] NULL,
[season_name] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[plan_event_name] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[event_name] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[price_code] [nvarchar] (4000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[qty] [int] NULL,
[rev] [decimal] (38, 6) NULL
)
GO
CREATE CLUSTERED COLUMNSTORE INDEX [CCI_stg__TicketBase] ON [stg].[TicketBase]
GO
