CREATE TABLE [dbo].[ConsumerQuizQuestionBankByLanguage]
(
[QuestionID] [int] NOT NULL,
[LanguageID] [smallint] NOT NULL,
[Question] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ConsumerQuizQuestionBankByLanguage] ADD CONSTRAINT [PK_ConsumerQuizQuestionBankByLanguage] PRIMARY KEY CLUSTERED  ([QuestionID], [LanguageID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ConsumerQuizQuestionBankByLanguage] ADD CONSTRAINT [FK_ConsumerQuizQuestionBankByLanguage_ConsumerQuizQuestionBank] FOREIGN KEY ([QuestionID]) REFERENCES [dbo].[ConsumerQuizQuestionBank] ([QuestionID])
GO
ALTER TABLE [dbo].[ConsumerQuizQuestionBankByLanguage] ADD CONSTRAINT [FK_ConsumerQuizQuestionBankByLanguage_Language] FOREIGN KEY ([LanguageID]) REFERENCES [dbo].[Language] ([LanguageId])
GO
