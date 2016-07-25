CREATE TABLE [dbo].[SupplierAllowedConsumerAction]
(
[SupplierID] [int] NOT NULL,
[ConsumerActionID] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SupplierAllowedConsumerAction] ADD CONSTRAINT [PK_SupplierAllowedConsumerActions] PRIMARY KEY CLUSTERED  ([SupplierID], [ConsumerActionID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SupplierAllowedConsumerAction] ADD CONSTRAINT [FK_SupplierAllowedConsumerActions_ConsumerActions] FOREIGN KEY ([ConsumerActionID]) REFERENCES [dbo].[ConsumerActions] ([ConsumerActionID])
GO
