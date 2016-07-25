CREATE TABLE [dbo].[GoodHealthQuestionnaireAnswerSetByLanguage]
(
[AnswerSetID] [int] NOT NULL,
[LanguageID] [smallint] NOT NULL,
[AnswerValue] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[GoodHealthQuestionnaireAnswerSetByLanguage] ADD CONSTRAINT [FK_GoodHealthQuestionnaireAnswerSetByLanguage_GoodHealthQuestionnaireAnswerSet] FOREIGN KEY ([AnswerSetID]) REFERENCES [dbo].[GoodHealthQuestionnaireAnswerSet] ([AnswerSetID]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[GoodHealthQuestionnaireAnswerSetByLanguage] ADD CONSTRAINT [FK_GoodHealthQuestionnaireAnswerSetByLanguage_Language] FOREIGN KEY ([LanguageID]) REFERENCES [dbo].[Language] ([LanguageId]) ON DELETE CASCADE
GO
