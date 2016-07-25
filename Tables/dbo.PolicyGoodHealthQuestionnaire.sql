CREATE TABLE [dbo].[PolicyGoodHealthQuestionnaire]
(
[PolicyGoodHealthQuestionnaireID] [bigint] NOT NULL IDENTITY(1, 1),
[PolicyID] [bigint] NOT NULL,
[GoodHealthQuestionnaireID] [int] NOT NULL,
[ProviderFormNumber] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PolicyGoodHealthQuestionnaire] ADD CONSTRAINT [PK_PolicyGoodHealthQuestionnaire] PRIMARY KEY CLUSTERED  ([PolicyGoodHealthQuestionnaireID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PolicyGoodHealthQuestionnaire] ADD CONSTRAINT [FK_PolicyGoodHealthQuestionnaire_GoodHealthQuestionnaire] FOREIGN KEY ([GoodHealthQuestionnaireID]) REFERENCES [dbo].[GoodHealthQuestionnaire] ([GoodHealthQuestionnaireID]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PolicyGoodHealthQuestionnaire] ADD CONSTRAINT [FK_PolicyGoodHealthQuestionnaire_Policy] FOREIGN KEY ([PolicyID]) REFERENCES [dbo].[Policy] ([PolicyID]) ON DELETE CASCADE
GO
