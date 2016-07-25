CREATE TABLE [dbo].[NotificationRecipient]
(
[NotificationRecipientId] [int] NOT NULL,
[ActionID] [smallint] NOT NULL,
[PolicyStatusID] [int] NOT NULL,
[UserTypeID] [smallint] NOT NULL,
[PolicyDeliveryTypeID] [int] NOT NULL,
[NotificationTemplateDefaultID] [int] NOT NULL,
[Active] [bit] NOT NULL CONSTRAINT [DF__Notificat__Activ__679F3DB8] DEFAULT ((1)),
[ConfigurationKey] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[NotificationRecipient] ADD CONSTRAINT [PK_NotificationRecipient_1] PRIMARY KEY CLUSTERED  ([NotificationRecipientId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[NotificationRecipient] ADD CONSTRAINT [FK_NotificationRecipientDefault_Action] FOREIGN KEY ([ActionID]) REFERENCES [dbo].[Action] ([ActionID])
GO
ALTER TABLE [dbo].[NotificationRecipient] ADD CONSTRAINT [FK_NotificationRecipientDefault_NotificationTemplateDefault] FOREIGN KEY ([NotificationTemplateDefaultID]) REFERENCES [dbo].[NotificationTemplateDefault] ([NotificationTemplateID])
GO
ALTER TABLE [dbo].[NotificationRecipient] ADD CONSTRAINT [FK_NotificationRecipientDefault_PolicyStatus] FOREIGN KEY ([PolicyStatusID]) REFERENCES [dbo].[PolicyStatus] ([PolicyStatusID])
GO
ALTER TABLE [dbo].[NotificationRecipient] ADD CONSTRAINT [FK_NotificationRecipientDefault_UserType] FOREIGN KEY ([UserTypeID]) REFERENCES [dbo].[UserType] ([UserTypeID])
GO
