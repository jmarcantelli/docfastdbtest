CREATE TABLE [dbo].[DocumentTypeByLanguage]
(
[DocumentTypeID] [smallint] NOT NULL,
[LanguageID] [smallint] NOT NULL,
[DocumentTypeName] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Description] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DocumentTypeByLanguage] ADD CONSTRAINT [PK_DocumentTypeByLanguage] PRIMARY KEY CLUSTERED  ([DocumentTypeID], [LanguageID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DocumentTypeByLanguage] ADD CONSTRAINT [FK_DocumentTypeByLanguage_DocumentType] FOREIGN KEY ([DocumentTypeID]) REFERENCES [dbo].[DocumentType] ([DocumentTypeID])
GO
ALTER TABLE [dbo].[DocumentTypeByLanguage] ADD CONSTRAINT [FK_DocumentTypeByLanguage_Language] FOREIGN KEY ([LanguageID]) REFERENCES [dbo].[Language] ([LanguageId])
GO
