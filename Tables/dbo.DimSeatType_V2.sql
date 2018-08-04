CREATE TABLE [dbo].[DimSeatType_V2]
(
[DimSeatTypeId] [int] NOT NULL IDENTITY(1, 1),
[ETL__SourceSystem] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ETL__CreatedDate] [datetime] NOT NULL,
[ETL__UpdatedDate] [datetime] NOT NULL,
[ETL__IsDeleted] [bit] NOT NULL,
[ETL__DeltaHashKey] [binary] (32) NULL,
[SeatTypeCode] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SeatTypeName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SeatTypeDesc] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SeatTypeClass] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Config_Category1] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Config_Category2] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Config_Category3] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Config_Category4] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Config_Category5] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Custom_Int_1] [int] NULL,
[Custom_Int_2] [int] NULL,
[Custom_Int_3] [int] NULL,
[Custom_Int_4] [int] NULL,
[Custom_Int_5] [int] NULL,
[Custom_Dec_1] [decimal] (18, 6) NULL,
[Custom_Dec_2] [decimal] (18, 6) NULL,
[Custom_Dec_3] [decimal] (18, 6) NULL,
[Custom_Dec_4] [decimal] (18, 6) NULL,
[Custom_Dec_5] [decimal] (18, 6) NULL,
[Custom_DateTime_1] [datetime] NULL,
[Custom_DateTime_2] [datetime] NULL,
[Custom_DateTime_3] [datetime] NULL,
[Custom_DateTime_4] [datetime] NULL,
[Custom_DateTime_5] [datetime] NULL,
[Custom_Bit_1] [bit] NULL,
[Custom_Bit_2] [bit] NULL,
[Custom_Bit_3] [bit] NULL,
[Custom_Bit_4] [bit] NULL,
[Custom_Bit_5] [bit] NULL,
[Custom_nVarChar_1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Custom_nVarChar_2] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Custom_nVarChar_3] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Custom_nVarChar_4] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Custom_nVarChar_5] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [dbo].[DimSeatType_V2] ADD CONSTRAINT [PK_dbo__DimSeatType_V2] PRIMARY KEY CLUSTERED  ([DimSeatTypeId])
GO
CREATE NONCLUSTERED INDEX [IX_ETL__IsDeleted] ON [dbo].[DimSeatType_V2] ([ETL__IsDeleted])
GO
CREATE NONCLUSTERED INDEX [IX_ETL__SourceSystem] ON [dbo].[DimSeatType_V2] ([ETL__SourceSystem])
GO
CREATE NONCLUSTERED INDEX [IX_ETL__UpdatedDate] ON [dbo].[DimSeatType_V2] ([ETL__UpdatedDate] DESC)
GO
CREATE NONCLUSTERED INDEX [IX_SeatTypeCode] ON [dbo].[DimSeatType_V2] ([SeatTypeCode])
GO
