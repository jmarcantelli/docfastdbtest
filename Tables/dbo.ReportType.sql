CREATE TABLE [dbo].[ReportType]
(
[ReportTypeID] [smallint] NOT NULL,
[ReportTypeName] [nvarchar] (400) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ReportType] ADD CONSTRAINT [PK_ReportType] PRIMARY KEY CLUSTERED  ([ReportTypeID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ReportType] ADD CONSTRAINT [uc_ReportType_ReportTypeName] UNIQUE NONCLUSTERED  ([ReportTypeName]) ON [PRIMARY]
GO
