CREATE TABLE [dbo].[SupplierScreen]
(
[SupplierScreenID] [int] NOT NULL IDENTITY(1, 1),
[SupplierID] [int] NOT NULL,
[ScreenID] [smallint] NOT NULL,
[WorkflowOrder] [smallint] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SupplierScreen] ADD CONSTRAINT [PK_SupplierScreen] PRIMARY KEY CLUSTERED  ([SupplierScreenID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SupplierScreen] ADD CONSTRAINT [UC_SupplierScreen] UNIQUE NONCLUSTERED  ([SupplierID], [ScreenID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SupplierScreen] ADD CONSTRAINT [FK_SupplierScreen_Screen] FOREIGN KEY ([ScreenID]) REFERENCES [dbo].[Screen] ([ScreenID])
GO
ALTER TABLE [dbo].[SupplierScreen] ADD CONSTRAINT [FK_SupplierScreen_SupplierIdentifier] FOREIGN KEY ([SupplierID]) REFERENCES [dbo].[SupplierIdentifier] ([SupplierID])
GO
