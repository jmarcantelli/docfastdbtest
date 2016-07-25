CREATE TABLE [dbo].[KnockOutAnswerChoice]
(
[AnswerID] [bigint] NOT NULL IDENTITY(1, 1),
[QuestionID] [bigint] NOT NULL,
[Ordinal] [int] NOT NULL,
[AnswerChoiceText] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[KnockOutAnswer] [bit] NOT NULL,
[DetailOnAnswer] [bit] NOT NULL,
[SelectedAnswer] [bit] NULL,
[AnswerDate] [datetime] NULL,
[CreatedBy] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CreateDate] [datetime] NOT NULL,
[ModifiedBy] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ModifiedDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[KnockOutAnswerChoice] ADD CONSTRAINT [PK_KnockOutAnswerChoice] PRIMARY KEY CLUSTERED  ([AnswerID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[KnockOutAnswerChoice] ADD CONSTRAINT [FK_KnockOutAnswerChoice_KnockOutQuestion] FOREIGN KEY ([QuestionID]) REFERENCES [dbo].[KnockOutQuestion] ([QuestionID])
GO
EXEC sp_addextendedproperty N'MS_Description', N'The text of the actual answer choice.', 'SCHEMA', N'dbo', 'TABLE', N'KnockOutAnswerChoice', 'COLUMN', N'AnswerChoiceText'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The date/time that the consumer answered the question.', 'SCHEMA', N'dbo', 'TABLE', N'KnockOutAnswerChoice', 'COLUMN', N'AnswerDate'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Unique identifier of the Answer.', 'SCHEMA', N'dbo', 'TABLE', N'KnockOutAnswerChoice', 'COLUMN', N'AnswerID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'When set to true, the Consumer must provide more detailed information if they answered with the "KnockOut Response".', 'SCHEMA', N'dbo', 'TABLE', N'KnockOutAnswerChoice', 'COLUMN', N'DetailOnAnswer'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Set to true if selecting this answer knocks the consumer out of receiving the policy.', 'SCHEMA', N'dbo', 'TABLE', N'KnockOutAnswerChoice', 'COLUMN', N'KnockOutAnswer'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The order in which the answer should appear to the Consumer.', 'SCHEMA', N'dbo', 'TABLE', N'KnockOutAnswerChoice', 'COLUMN', N'Ordinal'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The Question that this Answer is assocaited with.', 'SCHEMA', N'dbo', 'TABLE', N'KnockOutAnswerChoice', 'COLUMN', N'QuestionID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Set to true if the consumer selected this answer.', 'SCHEMA', N'dbo', 'TABLE', N'KnockOutAnswerChoice', 'COLUMN', N'SelectedAnswer'
GO
