CREATE TABLE [dbo].[GoodHealthQuestionnaireQuestion]
(
[QuestionID] [int] NOT NULL IDENTITY(1, 1),
[GoodHealthQuestionnaireID] [int] NOT NULL,
[Sequence] [smallint] NOT NULL,
[QuestionText] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AnswerGroupName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[GoodHealthQuestionnaireQuestion] ADD CONSTRAINT [PK_GoodHealthQuestionnaireQuestion] PRIMARY KEY CLUSTERED  ([QuestionID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[GoodHealthQuestionnaireQuestion] ADD CONSTRAINT [FK_GoodHealthQuestionnaireQuestion_GoodHealthQuestionnaire] FOREIGN KEY ([GoodHealthQuestionnaireID]) REFERENCES [dbo].[GoodHealthQuestionnaire] ([GoodHealthQuestionnaireID]) ON DELETE CASCADE
GO
