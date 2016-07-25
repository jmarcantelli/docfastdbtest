CREATE TABLE [dbo].[SupplierCustomText]
(
[SupplierCustomTextID] [int] NOT NULL,
[SupplierID] [int] NOT NULL,
[PackageTypeID] [smallint] NULL,
[CustomTextKey] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CustomTextValue] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CreatedBy] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CreateDate] [datetime] NOT NULL CONSTRAINT [DF_SupplierCustomText_CreateDate] DEFAULT (getdate()),
[ModifiedBy] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_SupplierCustomText_ModifiedDate] DEFAULT (getdate()),
[Description] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[SupplierCustomText] ADD CONSTRAINT [PK_SupplierCustomText] PRIMARY KEY CLUSTERED  ([SupplierCustomTextID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SupplierCustomText] ADD CONSTRAINT [IX_SupplierProductTypeCustomText] UNIQUE NONCLUSTERED  ([SupplierID], [PackageTypeID], [CustomTextKey]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SupplierCustomText] ADD CONSTRAINT [FK_SupplierCustomText_PackageType] FOREIGN KEY ([PackageTypeID]) REFERENCES [dbo].[PackageType] ([PackageTypeID])
GO
ALTER TABLE [dbo].[SupplierCustomText] ADD CONSTRAINT [FK_SupplierCustomText_SupplierIdentifier] FOREIGN KEY ([SupplierID]) REFERENCES [dbo].[SupplierIdentifier] ([SupplierID])
GO
EXEC sp_addextendedproperty N'MS_Descriptions', N'This table defines any custom texts/HTML to be set for the Supplier.', 'SCHEMA', N'dbo', 'TABLE', N'SupplierCustomText', NULL, NULL
GO
