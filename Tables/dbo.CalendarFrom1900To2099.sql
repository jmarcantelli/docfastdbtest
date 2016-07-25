CREATE TABLE [dbo].[CalendarFrom1900To2099]
(
[DateId] [date] NOT NULL,
[DateYear] [smallint] NULL,
[DateMonth] [tinyint] NULL,
[DateDay] [tinyint] NULL,
[WeekdayId] [tinyint] NULL,
[WeekdayName] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MonthName] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DayOfYear] [smallint] NULL,
[QuarterId] [tinyint] NULL,
[FirstDayOfMonth] [date] NULL,
[LastDayOfMonth] [date] NULL,
[StartDTS] [datetime] NULL,
[EndDTS] [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CalendarFrom1900To2099] ADD CONSTRAINT [PK__Calendar__A426F233AF23CAC4] PRIMARY KEY CLUSTERED  ([DateId]) ON [PRIMARY]
GO
