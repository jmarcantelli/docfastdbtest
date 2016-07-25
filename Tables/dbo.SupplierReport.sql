CREATE TABLE [dbo].[SupplierReport]
(
[SupplierID] [int] NOT NULL,
[ReportID] [smallint] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SupplierReport] ADD CONSTRAINT [PK_SupplierReport] PRIMARY KEY CLUSTERED  ([SupplierID], [ReportID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SupplierReport] ADD CONSTRAINT [FK_SupplierReport_Report] FOREIGN KEY ([ReportID]) REFERENCES [dbo].[Report] ([ReportID])
GO
ALTER TABLE [dbo].[SupplierReport] ADD CONSTRAINT [FK_SupplierReport_SupplierIdentifier] FOREIGN KEY ([SupplierID]) REFERENCES [dbo].[SupplierIdentifier] ([SupplierID])
GO
