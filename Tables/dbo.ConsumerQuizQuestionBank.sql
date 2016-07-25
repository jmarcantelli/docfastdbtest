CREATE TABLE [dbo].[ConsumerQuizQuestionBank]
(
[QuestionID] [int] NOT NULL,
[Question] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Active] [bit] NOT NULL,
[DisplayOrder] [smallint] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ConsumerQuizQuestionBank] ADD CONSTRAINT [PK_ConsumerQuizQuestionBank] PRIMARY KEY CLUSTERED  ([QuestionID]) ON [PRIMARY]
GO
