CREATE TABLE [dbo].[SupplierPackageType]
(
[SupplierPackageTypeID] [int] NOT NULL IDENTITY(1, 1),
[SupplierID] [int] NOT NULL,
[PackageTypeID] [smallint] NOT NULL,
[MappingID] [smallint] NOT NULL,
[ActiveFlag] [bit] NOT NULL CONSTRAINT [DF_SupplierPackageType_Active] DEFAULT ((1)),
[DocuSignBrandId] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SupplierPackageType] ADD CONSTRAINT [PK_SupplierPackageType] PRIMARY KEY CLUSTERED  ([SupplierID], [PackageTypeID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SupplierPackageType] ADD CONSTRAINT [uqc_SupplierID_MappingID] UNIQUE NONCLUSTERED  ([SupplierID], [MappingID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SupplierPackageType] ADD CONSTRAINT [FK_SupplierPackageType_PackageType] FOREIGN KEY ([PackageTypeID]) REFERENCES [dbo].[PackageType] ([PackageTypeID])
GO
ALTER TABLE [dbo].[SupplierPackageType] ADD CONSTRAINT [FK_SupplierPackageType_SupplierIdentifier] FOREIGN KEY ([SupplierID]) REFERENCES [dbo].[SupplierIdentifier] ([SupplierID])
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table contains the list of all Package types that are available for a supplier.', 'SCHEMA', N'dbo', 'TABLE', N'SupplierPackageType', NULL, NULL
GO
