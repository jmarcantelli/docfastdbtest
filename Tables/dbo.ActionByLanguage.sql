CREATE TABLE [dbo].[ActionByLanguage]
(
[ActionID] [smallint] NOT NULL,
[LanguageID] [smallint] NOT NULL,
[Action] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ActionByLanguage] ADD CONSTRAINT [PK_ActionByLanguage] PRIMARY KEY CLUSTERED  ([ActionID], [LanguageID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ActionByLanguage] ADD CONSTRAINT [FK_ActionByLanguage_Action] FOREIGN KEY ([ActionID]) REFERENCES [dbo].[Action] ([ActionID])
GO
ALTER TABLE [dbo].[ActionByLanguage] ADD CONSTRAINT [FK_ActionByLanguage_Language] FOREIGN KEY ([LanguageID]) REFERENCES [dbo].[Language] ([LanguageId])
GO
