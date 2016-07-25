CREATE TABLE [dbo].[StateByLanguage]
(
[StateID] [smallint] NOT NULL,
[LanguageID] [smallint] NOT NULL,
[StateName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[StateByLanguage] ADD CONSTRAINT [PK_StateByLanguage] PRIMARY KEY CLUSTERED  ([StateID], [LanguageID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[StateByLanguage] ADD CONSTRAINT [FK_StateByLanguage_Language] FOREIGN KEY ([LanguageID]) REFERENCES [dbo].[Language] ([LanguageId])
GO
ALTER TABLE [dbo].[StateByLanguage] ADD CONSTRAINT [FK_StateByLanguage_State] FOREIGN KEY ([StateID]) REFERENCES [dbo].[State] ([StateID])
GO
ALTER TABLE [dbo].[StateByLanguage] ADD CONSTRAINT [FK_StateByLanguage_StateByLanguage] FOREIGN KEY ([StateID], [LanguageID]) REFERENCES [dbo].[StateByLanguage] ([StateID], [LanguageID])
GO
