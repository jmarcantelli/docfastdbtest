CREATE TABLE [dbo].[SupplierConfigurations]
(
[SupplierID] [int] NOT NULL,
[ConfigurationKey] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ConfigurationValue] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CreatedBy] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CreateDate] [datetime] NOT NULL CONSTRAINT [DF_SupplierConfigurations_CreateDate] DEFAULT (getdate()),
[ModifiedBy] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_SupplierConfigurations_ModifiedDate] DEFAULT (getdate()),
[Description] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PackageTypeID] [smallint] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[SupplierConfigurations] ADD CONSTRAINT [UC_SupplierConfigurations_PackageType] UNIQUE NONCLUSTERED  ([SupplierID], [ConfigurationKey], [PackageTypeID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SupplierConfigurations] ADD CONSTRAINT [FK_SupplierConfigurations_PackageType] FOREIGN KEY ([PackageTypeID]) REFERENCES [dbo].[PackageType] ([PackageTypeID])
GO
EXEC sp_addextendedproperty N'MS_Descriptions', N'This table defines any configurations to be set for the Supplier.', 'SCHEMA', N'dbo', 'TABLE', N'SupplierConfigurations', NULL, NULL
GO
