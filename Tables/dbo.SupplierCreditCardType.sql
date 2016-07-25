CREATE TABLE [dbo].[SupplierCreditCardType]
(
[SupplierID] [int] NOT NULL,
[CreditCardTypeID] [smallint] NOT NULL,
[DisplayOrder] [smallint] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SupplierCreditCardType] ADD CONSTRAINT [PK_SupplierCreditCardType] PRIMARY KEY CLUSTERED  ([SupplierID], [CreditCardTypeID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SupplierCreditCardType] ADD CONSTRAINT [FK_SupplierCreditCardType_CreditCardType] FOREIGN KEY ([CreditCardTypeID]) REFERENCES [dbo].[CreditCardType] ([CreditCardTypeID])
GO
ALTER TABLE [dbo].[SupplierCreditCardType] ADD CONSTRAINT [FK_SupplierCreditCardType_SupplierIdentifier] FOREIGN KEY ([SupplierID]) REFERENCES [dbo].[SupplierIdentifier] ([SupplierID])
GO
