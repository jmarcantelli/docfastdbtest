CREATE TABLE [dbo].[ConsumerQuiz]
(
[ConsumerQuizID] [bigint] NOT NULL IDENTITY(1, 1),
[ConsumerRecipientID] [bigint] NOT NULL,
[QuizXML] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Passed] [bit] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[ConsumerQuiz] ADD CONSTRAINT [PK_ConsumerQuiz] PRIMARY KEY CLUSTERED  ([ConsumerQuizID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ConsumerQuiz] ADD CONSTRAINT [FK_ConsumerQuiz_ConsumerRecipient] FOREIGN KEY ([ConsumerRecipientID]) REFERENCES [dbo].[ConsumerRecipient] ([ConsumerRecipientID])
GO
