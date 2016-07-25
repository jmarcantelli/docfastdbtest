CREATE TABLE [dbo].[SupplierCustomTextByLanguage]
(
[SupplierCustomTextID] [int] NOT NULL,
[LanguageID] [smallint] NOT NULL,
[CustomTextValue] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[SupplierCustomTextByLanguage] ADD CONSTRAINT [PK_SupplierCustomTextByLanguage] PRIMARY KEY CLUSTERED  ([SupplierCustomTextID], [LanguageID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SupplierCustomTextByLanguage] ADD CONSTRAINT [FK_SupplierCustomTextByLanguage_Language] FOREIGN KEY ([LanguageID]) REFERENCES [dbo].[Language] ([LanguageId])
GO
ALTER TABLE [dbo].[SupplierCustomTextByLanguage] ADD CONSTRAINT [FK_SupplierCustomTextByLanguage_SupplierCustomText] FOREIGN KEY ([SupplierCustomTextID]) REFERENCES [dbo].[SupplierCustomText] ([SupplierCustomTextID])
GO
ALTER TABLE [dbo].[SupplierCustomTextByLanguage] ADD CONSTRAINT [FK_SupplierCustomTextByLanguage_SupplierCustomTextByLanguage] FOREIGN KEY ([SupplierCustomTextID], [LanguageID]) REFERENCES [dbo].[SupplierCustomTextByLanguage] ([SupplierCustomTextID], [LanguageID])
GO
