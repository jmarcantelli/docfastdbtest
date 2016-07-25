CREATE TABLE [dbo].[SupplierTemplatesByLanguage]
(
[SupplierTemplateID] [int] NOT NULL,
[LanguageID] [smallint] NOT NULL,
[Description] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SupplierTemplatesByLanguage] ADD CONSTRAINT [PK_SupplierTemplatesByLanguage] PRIMARY KEY CLUSTERED  ([SupplierTemplateID], [LanguageID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SupplierTemplatesByLanguage] ADD CONSTRAINT [FK_SupplierTemplatesByLanguage_Language] FOREIGN KEY ([LanguageID]) REFERENCES [dbo].[Language] ([LanguageId])
GO
ALTER TABLE [dbo].[SupplierTemplatesByLanguage] ADD CONSTRAINT [FK_SupplierTemplatesByLanguage_SupplierTemplates] FOREIGN KEY ([SupplierTemplateID]) REFERENCES [dbo].[SupplierTemplates] ([SupplierTemplateID])
GO
