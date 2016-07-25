CREATE TABLE [dbo].[GoodHealthQuestionnaireQuestionByLanguage]
(
[QuestionID] [int] NOT NULL,
[LanguageID] [smallint] NOT NULL,
[QuestionText] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[GoodHealthQuestionnaireQuestionByLanguage] ADD CONSTRAINT [FK_GoodHealthQuestionnaireQuestionByLanguage_GoodHealthQuestionnaireQuestion] FOREIGN KEY ([QuestionID]) REFERENCES [dbo].[GoodHealthQuestionnaireQuestion] ([QuestionID]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[GoodHealthQuestionnaireQuestionByLanguage] ADD CONSTRAINT [FK_GoodHealthQuestionnaireQuestionByLanguage_Language] FOREIGN KEY ([LanguageID]) REFERENCES [dbo].[Language] ([LanguageId]) ON DELETE CASCADE
GO
