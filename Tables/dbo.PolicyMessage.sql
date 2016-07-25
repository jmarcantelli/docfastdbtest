CREATE TABLE [dbo].[PolicyMessage]
(
[PolicyMessageID] [bigint] NOT NULL IDENTITY(1, 1),
[PolicyID] [bigint] NOT NULL,
[MessageID] [int] NOT NULL,
[MessageDate] [datetime] NOT NULL,
[FromUserID] [int] NULL,
[FromConsumerRecipientID] [bigint] NULL,
[ToUserID] [int] NULL,
[MessageText] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RelatedPolicyActivityHistoryID] [bigint] NULL,
[Archived] [bit] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[PolicyMessage] ADD CONSTRAINT [PK_PolicyMessage] PRIMARY KEY CLUSTERED  ([PolicyMessageID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PolicyMessage] ADD CONSTRAINT [FK_PolicyMessage_Message] FOREIGN KEY ([MessageID]) REFERENCES [dbo].[Message] ([MessageID])
GO
ALTER TABLE [dbo].[PolicyMessage] ADD CONSTRAINT [FK_PolicyMessage_Policy] FOREIGN KEY ([PolicyID]) REFERENCES [dbo].[Policy] ([PolicyID])
GO
ALTER TABLE [dbo].[PolicyMessage] ADD CONSTRAINT [FK_PolicyMessage_PolicyActivityHistory] FOREIGN KEY ([RelatedPolicyActivityHistoryID]) REFERENCES [dbo].[PolicyActivityHistory] ([PolicyActivityHistoryID])
GO
ALTER TABLE [dbo].[PolicyMessage] ADD CONSTRAINT [FK_PolicyMessage_PolicyEXUser] FOREIGN KEY ([FromUserID]) REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[PolicyMessage] ADD CONSTRAINT [FK_PolicyMessage_PolicyEXUser1] FOREIGN KEY ([ToUserID]) REFERENCES [dbo].[User] ([UserID])
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table contains all messages in the system (i.e. Reasons for NTO, Delivery Extension Requests, etc.).  Some of these messages will be messages to an entity against the policy in general (Deliver Extension Request to the Carrier Case Manager) or to a specific user.', 'SCHEMA', N'dbo', 'TABLE', N'PolicyMessage', NULL, NULL
GO
