CREATE TABLE [dbo].[DocumentInvisibleUser]
(
[DocumentInvisibleUserID] [bigint] NOT NULL IDENTITY(1, 1),
[AttachmentID] [bigint] NOT NULL,
[UserID] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DocumentInvisibleUser] ADD CONSTRAINT [PK_DocumentInvisibleUser] PRIMARY KEY CLUSTERED  ([DocumentInvisibleUserID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DocumentInvisibleUser] ADD CONSTRAINT [uc_User_Attachment] UNIQUE NONCLUSTERED  ([UserID], [AttachmentID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DocumentInvisibleUser] ADD CONSTRAINT [FK_DocumentInvisibleUser_Attachment] FOREIGN KEY ([AttachmentID]) REFERENCES [dbo].[PolicyAttachment] ([AttachmentID])
GO
ALTER TABLE [dbo].[DocumentInvisibleUser] ADD CONSTRAINT [FK_DocumentInvisibleUser_User] FOREIGN KEY ([UserID]) REFERENCES [dbo].[User] ([UserID])
GO
