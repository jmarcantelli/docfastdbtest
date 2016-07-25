CREATE TABLE [dbo].[DocumentInvisibleConsumer]
(
[DocumentInvisibleConsumerID] [bigint] NOT NULL IDENTITY(1, 1),
[AttachmentID] [bigint] NOT NULL,
[ConsumerRecipientID] [bigint] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DocumentInvisibleConsumer] ADD CONSTRAINT [PK_DocumentInvisibleConsumer] PRIMARY KEY CLUSTERED  ([DocumentInvisibleConsumerID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DocumentInvisibleConsumer] ADD CONSTRAINT [uc_ConsumerRecipient_Attachment] UNIQUE NONCLUSTERED  ([ConsumerRecipientID], [AttachmentID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DocumentInvisibleConsumer] ADD CONSTRAINT [FK_DocumentInvisibleConsumer_Attachment] FOREIGN KEY ([AttachmentID]) REFERENCES [dbo].[PolicyAttachment] ([AttachmentID])
GO
ALTER TABLE [dbo].[DocumentInvisibleConsumer] ADD CONSTRAINT [FK_DocumentInvisibleConsumer_ConsumerRecipient] FOREIGN KEY ([ConsumerRecipientID]) REFERENCES [dbo].[ConsumerRecipient] ([ConsumerRecipientID])
GO
