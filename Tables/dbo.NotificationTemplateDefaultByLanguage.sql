CREATE TABLE [dbo].[NotificationTemplateDefaultByLanguage]
(
[NotificationTemplateID] [int] NOT NULL,
[LanguageID] [smallint] NOT NULL,
[TemplateXSL] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[NotificationTemplateDefaultByLanguage] ADD CONSTRAINT [PK_NotificationTemplateDefaultByLanguage] PRIMARY KEY CLUSTERED  ([NotificationTemplateID], [LanguageID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[NotificationTemplateDefaultByLanguage] ADD CONSTRAINT [FK_NotificationTemplateDefaultByLanguage_Language] FOREIGN KEY ([LanguageID]) REFERENCES [dbo].[Language] ([LanguageId])
GO
ALTER TABLE [dbo].[NotificationTemplateDefaultByLanguage] ADD CONSTRAINT [FK_NotificationTemplateDefaultByLanguage_NotificationTemplateDefault] FOREIGN KEY ([NotificationTemplateID]) REFERENCES [dbo].[NotificationTemplateDefault] ([NotificationTemplateID])
GO
