CREATE TABLE [dbo].[UserEmail]
(
[UserEmailID] [int] NOT NULL IDENTITY(1, 1),
[UserID] [int] NOT NULL,
[EmailID] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[UserEmail] ADD CONSTRAINT [PK_UserEmail] PRIMARY KEY CLUSTERED  ([UserEmailID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[UserEmail] ADD CONSTRAINT [UQ_UserEmail] UNIQUE NONCLUSTERED  ([UserID], [EmailID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[UserEmail] ADD CONSTRAINT [FK_UserEmail_Email] FOREIGN KEY ([EmailID]) REFERENCES [dbo].[Email] ([EmailID])
GO
ALTER TABLE [dbo].[UserEmail] ADD CONSTRAINT [FK_UserEmail_User] FOREIGN KEY ([UserID]) REFERENCES [dbo].[User] ([UserID])
GO
