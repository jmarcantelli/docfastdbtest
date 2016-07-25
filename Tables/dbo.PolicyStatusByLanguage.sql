CREATE TABLE [dbo].[PolicyStatusByLanguage]
(
[PolicyStatusID] [int] NOT NULL,
[LanguageID] [smallint] NOT NULL,
[PolicyStatusName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PolicyStatusByLanguage] ADD CONSTRAINT [PK_PolicyStatusByLanguage] PRIMARY KEY CLUSTERED  ([PolicyStatusID], [LanguageID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PolicyStatusByLanguage] ADD CONSTRAINT [FK_PolicyStatusByLanguage_Language] FOREIGN KEY ([LanguageID]) REFERENCES [dbo].[Language] ([LanguageId])
GO
ALTER TABLE [dbo].[PolicyStatusByLanguage] ADD CONSTRAINT [FK_PolicyStatusByLanguage_PolicyStatus] FOREIGN KEY ([PolicyStatusID]) REFERENCES [dbo].[PolicyStatus] ([PolicyStatusID])
GO
ALTER TABLE [dbo].[PolicyStatusByLanguage] ADD CONSTRAINT [FK_PolicyStatusByLanguage_PolicyStatusByLanguage] FOREIGN KEY ([PolicyStatusID], [LanguageID]) REFERENCES [dbo].[PolicyStatusByLanguage] ([PolicyStatusID], [LanguageID])
GO
