CREATE TABLE [dbo].[NotificationRecipientSupplier]
(
[SupplierID] [int] NOT NULL,
[NotificationRecipientId] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[NotificationRecipientSupplier] ADD CONSTRAINT [PK_NotificationRecipientSupplier] PRIMARY KEY CLUSTERED  ([SupplierID], [NotificationRecipientId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[NotificationRecipientSupplier] ADD CONSTRAINT [FK_NotificationRecipientSupplier_NotificationRecipient] FOREIGN KEY ([NotificationRecipientId]) REFERENCES [dbo].[NotificationRecipient] ([NotificationRecipientId])
GO
ALTER TABLE [dbo].[NotificationRecipientSupplier] ADD CONSTRAINT [FK_NotificationRecipientSupplier_SupplierIdentifier] FOREIGN KEY ([SupplierID]) REFERENCES [dbo].[SupplierIdentifier] ([SupplierID])
GO
