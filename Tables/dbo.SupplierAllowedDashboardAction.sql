CREATE TABLE [dbo].[SupplierAllowedDashboardAction]
(
[SupplierID] [int] NOT NULL,
[DashboardActionID] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SupplierAllowedDashboardAction] ADD CONSTRAINT [PK_SupplierAllowedActions] PRIMARY KEY CLUSTERED  ([SupplierID], [DashboardActionID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SupplierAllowedDashboardAction] ADD CONSTRAINT [FK_SupplierAllowedActions_DashboardActions] FOREIGN KEY ([DashboardActionID]) REFERENCES [dbo].[DashboardActions] ([DashboardActionID])
GO
