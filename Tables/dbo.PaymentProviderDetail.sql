CREATE TABLE [dbo].[PaymentProviderDetail]
(
[PaymentProviderDetailID] [int] NOT NULL,
[PaymentProviderID] [smallint] NOT NULL,
[SupplierID] [int] NOT NULL,
[PaymentProviderDetailTypeID] [smallint] NOT NULL,
[PaymentProviderDetailValue] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PaymentProviderDetail] ADD CONSTRAINT [PK_PaymentProviderDetail] PRIMARY KEY CLUSTERED  ([PaymentProviderDetailID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PaymentProviderDetail] ADD CONSTRAINT [uc_PaymentProviderDetailSupplier] UNIQUE NONCLUSTERED  ([PaymentProviderID], [SupplierID], [PaymentProviderDetailTypeID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PaymentProviderDetail] ADD CONSTRAINT [FK_PaymentProviderDetail_PaymentProvider] FOREIGN KEY ([PaymentProviderID]) REFERENCES [dbo].[PaymentProvider] ([PaymentProviderID])
GO
ALTER TABLE [dbo].[PaymentProviderDetail] ADD CONSTRAINT [FK_PaymentProviderDetail_PaymentProviderDetailType] FOREIGN KEY ([PaymentProviderDetailTypeID]) REFERENCES [dbo].[PaymentProviderDetailType] ([PaymentProviderDetailTypeID])
GO
ALTER TABLE [dbo].[PaymentProviderDetail] ADD CONSTRAINT [FK_PaymentProviderDetail_SupplierIdentifier] FOREIGN KEY ([SupplierID]) REFERENCES [dbo].[SupplierIdentifier] ([SupplierID])
GO
