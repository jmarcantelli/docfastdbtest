CREATE TABLE [dbo].[GoodHealthQuestionnaireAnswerSet]
(
[AnswerSetID] [int] NOT NULL IDENTITY(1, 1),
[QuestionID] [int] NOT NULL,
[Sequence] [smallint] NOT NULL,
[AnswerValue] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[GoodHealthQuestionnaireAnswerSet] ADD CONSTRAINT [PK_GoodHealthQuestionnaireAnswerSet] PRIMARY KEY CLUSTERED  ([AnswerSetID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[GoodHealthQuestionnaireAnswerSet] ADD CONSTRAINT [FK_GoodHealthQuestionnaireAnswerSet_GoodHealthQuestionnaireQuestion] FOREIGN KEY ([QuestionID]) REFERENCES [dbo].[GoodHealthQuestionnaireQuestion] ([QuestionID]) ON DELETE CASCADE
GO
