CREATE TABLE [dbo].[SupplierPaymentTerm]
(
[SupplierID] [int] NOT NULL,
[PaymentTermID] [smallint] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SupplierPaymentTerm] ADD CONSTRAINT [PK_SupplierPaymentTerm] PRIMARY KEY CLUSTERED  ([SupplierID], [PaymentTermID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SupplierPaymentTerm] ADD CONSTRAINT [FK_SupplierPaymentTerm_PaymentTerm] FOREIGN KEY ([PaymentTermID]) REFERENCES [dbo].[PaymentTerm] ([PaymentTermID])
GO
ALTER TABLE [dbo].[SupplierPaymentTerm] ADD CONSTRAINT [FK_SupplierPaymentTerm_SupplierIdentifier] FOREIGN KEY ([SupplierID]) REFERENCES [dbo].[SupplierIdentifier] ([SupplierID])
GO
