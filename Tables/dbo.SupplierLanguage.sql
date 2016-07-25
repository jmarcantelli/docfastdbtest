CREATE TABLE [dbo].[SupplierLanguage]
(
[SupplierID] [int] NOT NULL,
[LanguageId] [smallint] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SupplierLanguage] ADD CONSTRAINT [PK_SupplierLanguage] PRIMARY KEY CLUSTERED  ([SupplierID], [LanguageId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SupplierLanguage] ADD CONSTRAINT [FK_SupplierLanguage_Language] FOREIGN KEY ([LanguageId]) REFERENCES [dbo].[Language] ([LanguageId])
GO
ALTER TABLE [dbo].[SupplierLanguage] ADD CONSTRAINT [FK_SupplierLanguage_SupplierIdentifier] FOREIGN KEY ([SupplierID]) REFERENCES [dbo].[SupplierIdentifier] ([SupplierID])
GO
