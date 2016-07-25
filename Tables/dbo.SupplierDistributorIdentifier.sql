CREATE TABLE [dbo].[SupplierDistributorIdentifier]
(
[DistributorID] [int] NOT NULL,
[SupplierID] [int] NOT NULL,
[IdentifyingValue] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CreatedBy] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CreateDate] [datetime] NOT NULL,
[IsCCAllowed] [bit] NOT NULL CONSTRAINT [DF_SupplierDistributorIdentifier_IsCCAllowed] DEFAULT ((0)),
[Active] [bit] NOT NULL CONSTRAINT [DF__SupplierD__Activ__762D5431] DEFAULT ((1))
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SupplierDistributorIdentifier] ADD CONSTRAINT [PK_SupplierDistributorIdentifier_1] PRIMARY KEY CLUSTERED  ([DistributorID], [SupplierID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SupplierDistributorIdentifier] ADD CONSTRAINT [FK_SupplierDistributorIdentifier_Distributor] FOREIGN KEY ([DistributorID]) REFERENCES [dbo].[Distributor] ([DistributorID])
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table defines the Distributor OrganizationKey VendorCode that will be used in the ACORD messages to identify the Distributors.  Each carrier has their own codes for a distributor and sometimes a carrier will have more than 1 code for the distributor (most often when 1 distributor buys another one).', 'SCHEMA', N'dbo', 'TABLE', N'SupplierDistributorIdentifier', NULL, NULL
GO
