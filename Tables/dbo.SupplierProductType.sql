CREATE TABLE [dbo].[SupplierProductType]
(
[SupplierProductTypeID] [int] NOT NULL IDENTITY(1, 1),
[SupplierID] [int] NOT NULL,
[ProductTypeID] [smallint] NOT NULL,
[DocuSignBrandId] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ActiveFlag] [bit] NOT NULL CONSTRAINT [DF_SupplierProductType_Active] DEFAULT ((1))
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SupplierProductType] ADD CONSTRAINT [PK_SupplierProductType] PRIMARY KEY CLUSTERED  ([SupplierID], [ProductTypeID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SupplierProductType] ADD CONSTRAINT [FK_SupplierProductType_ProductType] FOREIGN KEY ([ProductTypeID]) REFERENCES [dbo].[ProductType] ([ProductTypeID])
GO
ALTER TABLE [dbo].[SupplierProductType] ADD CONSTRAINT [FK_SupplierProductType_SupplierIdentifier] FOREIGN KEY ([SupplierID]) REFERENCES [dbo].[SupplierIdentifier] ([SupplierID])
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table contains the list of all product types that are available for a supplier.', 'SCHEMA', N'dbo', 'TABLE', N'SupplierProductType', NULL, NULL
GO
