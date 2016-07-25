CREATE TABLE [dbo].[SupplierPaymentTypeFilter]
(
[SupplierPaymentTypeFilterID] [int] NOT NULL IDENTITY(1, 1),
[SupplierPaymentTypeID] [int] NOT NULL,
[ProductTypeID] [smallint] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SupplierPaymentTypeFilter] ADD CONSTRAINT [PK_SupplierPaymentTypeFilter] PRIMARY KEY CLUSTERED  ([SupplierPaymentTypeFilterID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SupplierPaymentTypeFilter] ADD CONSTRAINT [uc_SupplierPaymentTypeFilter] UNIQUE NONCLUSTERED  ([SupplierPaymentTypeID], [ProductTypeID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SupplierPaymentTypeFilter] ADD CONSTRAINT [FK_SupplierPaymentTypeFilter_ProductType] FOREIGN KEY ([ProductTypeID]) REFERENCES [dbo].[ProductType] ([ProductTypeID])
GO
ALTER TABLE [dbo].[SupplierPaymentTypeFilter] ADD CONSTRAINT [FK_SupplierPaymentTypeFilter_SupplierPaymentType] FOREIGN KEY ([SupplierPaymentTypeID]) REFERENCES [dbo].[SupplierPaymentType] ([SupplierPaymentTypeID])
GO
