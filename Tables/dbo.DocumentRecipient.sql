CREATE TABLE [dbo].[DocumentRecipient]
(
[DocumentRecipientID] [bigint] NOT NULL IDENTITY(1, 1),
[DocumentID] [bigint] NOT NULL,
[ConsumerRecipientID] [bigint] NULL,
[UserID] [int] NULL,
[PolicyID] [bigint] NULL,
[DocumentStatusID] [smallint] NOT NULL,
[DocumentStatusDate] [datetime] NOT NULL,
[DocumentExpiryDate] [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DocumentRecipient] ADD CONSTRAINT [CK_DocumentRecipient_BothConsumerAndUser_NotNull] CHECK ((([ConsumerRecipientID] IS NOT NULL OR [UserID] IS NOT NULL) AND ([ConsumerRecipientID] IS NULL OR [UserID] IS NULL)))
GO
ALTER TABLE [dbo].[DocumentRecipient] ADD CONSTRAINT [PK_DocumentRecipient] PRIMARY KEY CLUSTERED  ([DocumentRecipientID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DocumentRecipient] ADD CONSTRAINT [UC_DocumentRecipient] UNIQUE NONCLUSTERED  ([DocumentID], [ConsumerRecipientID], [UserID], [PolicyID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DocumentRecipient] ADD CONSTRAINT [FK_DocumentRecipient_ConsumerRecipient] FOREIGN KEY ([ConsumerRecipientID]) REFERENCES [dbo].[ConsumerRecipient] ([ConsumerRecipientID])
GO
ALTER TABLE [dbo].[DocumentRecipient] ADD CONSTRAINT [FK_DocumentRecipient_Document] FOREIGN KEY ([DocumentID]) REFERENCES [dbo].[Document] ([DocumentID])
GO
ALTER TABLE [dbo].[DocumentRecipient] ADD CONSTRAINT [FK_DocumentRecipient_DocumentStatus] FOREIGN KEY ([DocumentStatusID]) REFERENCES [dbo].[DocumentStatus] ([DocumentStatusID])
GO
ALTER TABLE [dbo].[DocumentRecipient] ADD CONSTRAINT [FK_DocumentRecipient_Policy] FOREIGN KEY ([PolicyID]) REFERENCES [dbo].[Policy] ([PolicyID])
GO
ALTER TABLE [dbo].[DocumentRecipient] ADD CONSTRAINT [FK_DocumentRecipient_User] FOREIGN KEY ([UserID]) REFERENCES [dbo].[User] ([UserID])
GO
