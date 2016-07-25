CREATE TABLE [dbo].[SupplierAttributeKey]
(
[SupplierID] [int] NOT NULL,
[AttributeKeyId] [smallint] NOT NULL,
[AttributeKeyName] [nvarchar] (400) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SupplierAttributeKey] ADD CONSTRAINT [PK_SupplierAttributeKey] PRIMARY KEY CLUSTERED  ([SupplierID], [AttributeKeyId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SupplierAttributeKey] ADD CONSTRAINT [FK_SupplierAttributeKey_AttributeKey] FOREIGN KEY ([AttributeKeyId]) REFERENCES [dbo].[AttributeKey] ([AttributeKeyId])
GO
ALTER TABLE [dbo].[SupplierAttributeKey] ADD CONSTRAINT [FK_SupplierAttributeKey_SupplierIdentifier] FOREIGN KEY ([SupplierID]) REFERENCES [dbo].[SupplierIdentifier] ([SupplierID])
GO
