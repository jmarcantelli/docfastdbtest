CREATE TABLE [dbo].[SupplierPaymentMode]
(
[SupplierID] [int] NOT NULL,
[PaymentModeID] [smallint] NOT NULL,
[ModalAmtAttributeKey] [nvarchar] (400) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SupplierPaymentMode] ADD CONSTRAINT [PK_SupplierPaymentMode] PRIMARY KEY CLUSTERED  ([SupplierID], [PaymentModeID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SupplierPaymentMode] ADD CONSTRAINT [FK_SupplierPaymentMode_PaymentMode] FOREIGN KEY ([PaymentModeID]) REFERENCES [dbo].[PaymentMode] ([PaymentModeID])
GO
ALTER TABLE [dbo].[SupplierPaymentMode] ADD CONSTRAINT [FK_SupplierPaymentMode_SupplierIdentifier] FOREIGN KEY ([SupplierID]) REFERENCES [dbo].[SupplierIdentifier] ([SupplierID])
GO
