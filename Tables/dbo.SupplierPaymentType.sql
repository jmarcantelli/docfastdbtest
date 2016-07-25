CREATE TABLE [dbo].[SupplierPaymentType]
(
[SupplierPaymentTypeID] [int] NOT NULL,
[SupplierID] [int] NOT NULL,
[PaymentTypeID] [smallint] NOT NULL,
[ProviderFormNumber] [nvarchar] (400) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DisplayOrder] [smallint] NOT NULL,
[PaymentTermID] [smallint] NOT NULL CONSTRAINT [DF_SupplierPaymentType_PaymentTermID] DEFAULT ((1))
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SupplierPaymentType] ADD CONSTRAINT [PK_SupplierPaymentType] PRIMARY KEY CLUSTERED  ([SupplierPaymentTypeID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SupplierPaymentType] ADD CONSTRAINT [uc_SupplierPaymentType] UNIQUE NONCLUSTERED  ([SupplierID], [PaymentTypeID], [PaymentTermID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SupplierPaymentType] ADD CONSTRAINT [FK_SupplierPaymentType_PaymentTerm] FOREIGN KEY ([PaymentTermID]) REFERENCES [dbo].[PaymentTerm] ([PaymentTermID])
GO
ALTER TABLE [dbo].[SupplierPaymentType] ADD CONSTRAINT [FK_SupplierPaymentType_PaymentType] FOREIGN KEY ([PaymentTypeID]) REFERENCES [dbo].[PaymentType] ([PaymentTypeID])
GO
ALTER TABLE [dbo].[SupplierPaymentType] ADD CONSTRAINT [FK_SupplierPaymentType_SupplierIdentifier] FOREIGN KEY ([SupplierID]) REFERENCES [dbo].[SupplierIdentifier] ([SupplierID])
GO
