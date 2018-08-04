CREATE TABLE [dbo].[FBSeatCoordinates]
(
[SectionName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[RowName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Seat] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[X] [decimal] (18, 2) NULL,
[Y] [decimal] (18, 2) NULL
)
GO
