CREATE TABLE [dbo].[GoodHealthQuestionnaireByLanguage]
(
[GoodHealthQuestionnaireID] [int] NOT NULL,
[LanguageID] [smallint] NOT NULL,
[QuestionnaireName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Description] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[IntroductionText] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UnderwriterReviewText] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[GoodHealthQuestionnaireByLanguage] ADD CONSTRAINT [FK_GoodHealthQuestionnaireByLanguage_GoodHealthQuestionnaire] FOREIGN KEY ([GoodHealthQuestionnaireID]) REFERENCES [dbo].[GoodHealthQuestionnaire] ([GoodHealthQuestionnaireID]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[GoodHealthQuestionnaireByLanguage] ADD CONSTRAINT [FK_GoodHealthQuestionnaireByLanguage_Language] FOREIGN KEY ([LanguageID]) REFERENCES [dbo].[Language] ([LanguageId]) ON DELETE CASCADE
GO
