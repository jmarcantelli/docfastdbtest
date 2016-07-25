CREATE TABLE [dbo].[PolicyGoodHealthQuestionnaireAnswer]
(
[AnswerID] [bigint] NOT NULL IDENTITY(1, 1),
[PolicyGoodHealthQuestionnaireID] [bigint] NOT NULL,
[AnswerSetID] [int] NOT NULL,
[AdditionalInfo] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AdditionalInfoDate] [datetime] NULL,
[ProviderInfo] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PolicyGoodHealthQuestionnaireAnswer] ADD CONSTRAINT [PK_PolicyGoodHealthQuestionnaireAnswer] PRIMARY KEY CLUSTERED  ([AnswerID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PolicyGoodHealthQuestionnaireAnswer] ADD CONSTRAINT [FK_PolicyGoodHealthQuestionnaireAnswer_GoodHealthQuestionnaireAnswerSet] FOREIGN KEY ([AnswerSetID]) REFERENCES [dbo].[GoodHealthQuestionnaireAnswerSet] ([AnswerSetID])
GO
ALTER TABLE [dbo].[PolicyGoodHealthQuestionnaireAnswer] ADD CONSTRAINT [FK_PolicyGoodHealthQuestionnaireAnswer_PolicyGoodHealthQuestionnaire] FOREIGN KEY ([PolicyGoodHealthQuestionnaireID]) REFERENCES [dbo].[PolicyGoodHealthQuestionnaire] ([PolicyGoodHealthQuestionnaireID]) ON DELETE CASCADE
GO
