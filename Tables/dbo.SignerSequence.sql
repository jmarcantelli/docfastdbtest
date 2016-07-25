CREATE TABLE [dbo].[SignerSequence]
(
[SignerSequenceID] [int] NOT NULL IDENTITY(1, 1),
[SupplierID] [int] NOT NULL,
[PolicyDeliveryTypeID] [int] NOT NULL,
[Description] [nchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SignerSequence] ADD CONSTRAINT [PK_SignerSequence] PRIMARY KEY CLUSTERED  ([SignerSequenceID]) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_SignerSequence] ON [dbo].[SignerSequence] ([SupplierID], [PolicyDeliveryTypeID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SignerSequence] ADD CONSTRAINT [FK_SignerSequence_PolicyDeliveryType] FOREIGN KEY ([PolicyDeliveryTypeID]) REFERENCES [dbo].[PolicyDeliveryType] ([PolicyDeliveryTypeID])
GO
ALTER TABLE [dbo].[SignerSequence] ADD CONSTRAINT [FK_SignerSequence_SupplierIdentifier] FOREIGN KEY ([SupplierID]) REFERENCES [dbo].[SupplierIdentifier] ([SupplierID])
GO
