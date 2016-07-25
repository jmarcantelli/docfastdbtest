CREATE TABLE [dbo].[ConsumerRecipientAddress]
(
[ConsumerRecipientID] [bigint] NOT NULL,
[AddressID] [bigint] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ConsumerRecipientAddress] ADD CONSTRAINT [PK_ConsumerRecipientAddress] PRIMARY KEY CLUSTERED  ([ConsumerRecipientID], [AddressID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ConsumerRecipientAddress] ADD CONSTRAINT [FK_ConsumerRecipientAddress_Address] FOREIGN KEY ([AddressID]) REFERENCES [dbo].[Address] ([AddressID])
GO
ALTER TABLE [dbo].[ConsumerRecipientAddress] ADD CONSTRAINT [FK_ConsumerRecipientAddress_ConsumerRecipient] FOREIGN KEY ([ConsumerRecipientID]) REFERENCES [dbo].[ConsumerRecipient] ([ConsumerRecipientID])
GO
