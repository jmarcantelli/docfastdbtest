CREATE TABLE [dbo].[Report]
(
[ReportID] [smallint] NOT NULL,
[ReportName] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Description] [nvarchar] (4000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ProcName] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ReportTypeID] [smallint] NOT NULL CONSTRAINT [DF_Report_ReportTypeID] DEFAULT ((1))
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Report] ADD CONSTRAINT [PK_Report] PRIMARY KEY CLUSTERED  ([ReportID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Report] ADD CONSTRAINT [FK_Report_ReportType] FOREIGN KEY ([ReportTypeID]) REFERENCES [dbo].[ReportType] ([ReportTypeID])
GO
