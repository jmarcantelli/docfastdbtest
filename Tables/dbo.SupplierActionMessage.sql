CREATE TABLE [dbo].[SupplierActionMessage]
(
[SupplierActionMessageID] [int] NOT NULL IDENTITY(1, 1),
[SupplierID] [int] NOT NULL,
[ActionMessageID] [int] NOT NULL,
[Active] [bit] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SupplierActionMessage] ADD CONSTRAINT [PK_SupplierActionMessage] PRIMARY KEY CLUSTERED  ([SupplierActionMessageID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SupplierActionMessage] ADD CONSTRAINT [uc_SupplierActionMessage] UNIQUE NONCLUSTERED  ([SupplierID], [ActionMessageID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SupplierActionMessage] ADD CONSTRAINT [FK_SupplierActionMessage_ActionMessage] FOREIGN KEY ([ActionMessageID]) REFERENCES [dbo].[ActionMessage] ([ActionMessageID])
GO
ALTER TABLE [dbo].[SupplierActionMessage] ADD CONSTRAINT [FK_SupplierActionMessage_SupplierIdentifier] FOREIGN KEY ([SupplierID]) REFERENCES [dbo].[SupplierIdentifier] ([SupplierID])
GO
