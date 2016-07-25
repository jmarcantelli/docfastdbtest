CREATE TABLE [dbo].[ActionMessage]
(
[ActionMessageID] [int] NOT NULL IDENTITY(1, 1),
[MessageID] [int] NOT NULL,
[ActionID] [smallint] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ActionMessage] ADD CONSTRAINT [PK_ActionMessage] PRIMARY KEY CLUSTERED  ([ActionMessageID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ActionMessage] ADD CONSTRAINT [uc_ActionMessage] UNIQUE NONCLUSTERED  ([MessageID], [ActionID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ActionMessage] ADD CONSTRAINT [FK_ActionMessage_Action] FOREIGN KEY ([ActionID]) REFERENCES [dbo].[Action] ([ActionID])
GO
ALTER TABLE [dbo].[ActionMessage] ADD CONSTRAINT [FK_ActionMessage_Message] FOREIGN KEY ([MessageID]) REFERENCES [dbo].[Message] ([MessageID])
GO
