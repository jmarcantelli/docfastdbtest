CREATE TABLE [dbo].[Message]
(
[MessageID] [int] NOT NULL IDENTITY(1, 1),
[MessageTypeID] [int] NOT NULL,
[MessageValue] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[IsDefault] [bit] NOT NULL,
[ProductTypeID] [smallint] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[Message] ADD CONSTRAINT [PK_Message] PRIMARY KEY CLUSTERED  ([MessageID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IDX_Message_2876] ON [dbo].[Message] ([MessageTypeID], [IsDefault]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Message] ADD CONSTRAINT [FK_Message_MessageType] FOREIGN KEY ([MessageTypeID]) REFERENCES [dbo].[MessageType] ([MessageTypeID])
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table contains all messages in the system (i.e. Reasons for NTO, Delivery Extension Requests, etc.).  Some of these messages will be messages to an entity against the policy in general (Deliver Extension Request to the Carrier Case Manager) or to a specific user.', 'SCHEMA', N'dbo', 'TABLE', N'Message', NULL, NULL
GO
