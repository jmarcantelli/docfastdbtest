CREATE TABLE [dbo].[SupplierDistributorConfigurations]
(
[SupplierID] [int] NOT NULL,
[DistributorID] [int] NOT NULL,
[ConfigurationKey] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ConfigurationValue] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CreatedBy] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CreateDate] [datetime] NOT NULL CONSTRAINT [DF_SupplierDistributorConfigurations_CreateDate] DEFAULT (getdate()),
[ModifiedBy] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_SupplierDistributorConfigurations_ModifiedDate] DEFAULT (getdate()),
[Description] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[SupplierDistributorConfigurations] ADD CONSTRAINT [PK_SupplierDistributorConfigurations] PRIMARY KEY CLUSTERED  ([SupplierID], [DistributorID], [ConfigurationKey]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SupplierDistributorConfigurations] ADD CONSTRAINT [FK_SupplierDistributorConfigurations_Distributor] FOREIGN KEY ([DistributorID]) REFERENCES [dbo].[Distributor] ([DistributorID])
GO
ALTER TABLE [dbo].[SupplierDistributorConfigurations] ADD CONSTRAINT [FK_SupplierDistributorConfigurations_SupplierIdentifier] FOREIGN KEY ([SupplierID]) REFERENCES [dbo].[SupplierIdentifier] ([SupplierID])
GO
EXEC sp_addextendedproperty N'MS_Descriptions', N'This table defines any configurations to be set for the Supplier.', 'SCHEMA', N'dbo', 'TABLE', N'SupplierDistributorConfigurations', NULL, NULL
GO
