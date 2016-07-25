CREATE TABLE [dbo].[AlertTypeByLanguage]
(
[AlertTypeID] [int] NOT NULL,
[LanguageID] [smallint] NOT NULL,
[DisplayName] [nvarchar] (400) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AlertTypeByLanguage] ADD CONSTRAINT [PK_AlertTypeByLanguage] PRIMARY KEY CLUSTERED  ([AlertTypeID], [LanguageID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AlertTypeByLanguage] ADD CONSTRAINT [FK_AlertTypeByLanguage_AlertType] FOREIGN KEY ([AlertTypeID]) REFERENCES [dbo].[AlertType] ([AlertTypeID])
GO
ALTER TABLE [dbo].[AlertTypeByLanguage] ADD CONSTRAINT [FK_AlertTypeByLanguage_Language] FOREIGN KEY ([LanguageID]) REFERENCES [dbo].[Language] ([LanguageId])
GO
