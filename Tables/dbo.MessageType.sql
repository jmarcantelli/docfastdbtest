CREATE TABLE [dbo].[MessageType]
(
[MessageTypeID] [int] NOT NULL,
[Description] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DisplayName] [nvarchar] (400) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MessageType] ADD CONSTRAINT [PK_MessageType] PRIMARY KEY CLUSTERED  ([MessageTypeID]) ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'A list of the type of messages in the system (i.e. Reasons for NTO, Delivery Extension Requests, etc.).  ', 'SCHEMA', N'dbo', 'TABLE', N'MessageType', NULL, NULL
GO
