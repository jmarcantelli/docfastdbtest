CREATE TABLE [dbo].[PolicyNotification]
(
[PolicyNotificationID] [bigint] NOT NULL IDENTITY(1, 1),
[InitiatingUserTypeID] [smallint] NOT NULL,
[RecipientUserTypeID] [smallint] NOT NULL,
[DefaultNotificationTemplateID] [int] NOT NULL,
[IsNewNotification] [bit] NOT NULL,
[DateCreated] [datetime] NOT NULL CONSTRAINT [DF_PolicyNotification_DateCreated] DEFAULT (getdate()),
[PolicyID] [bigint] NOT NULL,
[InitiatingUserID] [bigint] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PolicyNotification] ADD CONSTRAINT [PK_PolicyNotification] PRIMARY KEY CLUSTERED  ([PolicyNotificationID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PolicyNotification] ADD CONSTRAINT [FK_PolicyNotification_InitiatingUserType] FOREIGN KEY ([InitiatingUserTypeID]) REFERENCES [dbo].[UserType] ([UserTypeID])
GO
ALTER TABLE [dbo].[PolicyNotification] ADD CONSTRAINT [FK_PolicyNotification_Policy] FOREIGN KEY ([PolicyID]) REFERENCES [dbo].[Policy] ([PolicyID])
GO
ALTER TABLE [dbo].[PolicyNotification] ADD CONSTRAINT [FK_PolicyNotification_RecipientUserType] FOREIGN KEY ([RecipientUserTypeID]) REFERENCES [dbo].[UserType] ([UserTypeID])
GO
