CREATE TABLE [dbo].[NotificationTemplateSupplierByLanguage]
(
[NotificationTemplateSupplierID] [int] NOT NULL,
[LanguageID] [smallint] NOT NULL,
[TemplateXSL] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[NotificationTemplateSupplierByLanguage] ADD CONSTRAINT [PK_NotificationTemplateSupplierByLanguage] PRIMARY KEY CLUSTERED  ([NotificationTemplateSupplierID], [LanguageID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[NotificationTemplateSupplierByLanguage] ADD CONSTRAINT [FK_NotificationTemplateSupplierByLanguage_Language] FOREIGN KEY ([LanguageID]) REFERENCES [dbo].[Language] ([LanguageId])
GO
ALTER TABLE [dbo].[NotificationTemplateSupplierByLanguage] ADD CONSTRAINT [FK_NotificationTemplateSupplierByLanguage_NotificationTemplateSupplier] FOREIGN KEY ([NotificationTemplateSupplierID]) REFERENCES [dbo].[NotificationTemplateSupplier] ([NotificationTemplateSupplierID])
GO
