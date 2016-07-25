CREATE TABLE [dbo].[KnockOutQuestion]
(
[QuestionID] [bigint] NOT NULL IDENTITY(1, 1),
[ConsumerRecipientID] [bigint] NOT NULL,
[Ordinal] [int] NOT NULL,
[QuestionText] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ResponseDetail] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CreatedBy] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CreateDate] [datetime] NOT NULL,
[ModifiedBy] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ModifiedDate] [datetime] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[KnockOutQuestion] ADD CONSTRAINT [PK_KnockOutQuestion] PRIMARY KEY CLUSTERED  ([QuestionID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[KnockOutQuestion] ADD CONSTRAINT [FK_KnockOutQuestion_ConsumerRecipient] FOREIGN KEY ([ConsumerRecipientID]) REFERENCES [dbo].[ConsumerRecipient] ([ConsumerRecipientID])
GO
EXEC sp_addextendedproperty N'MS_Description', N'The Policy the Question is associated with.', 'SCHEMA', N'dbo', 'TABLE', N'KnockOutQuestion', 'COLUMN', N'ConsumerRecipientID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The order in which the questions should appear to the Consumer.', 'SCHEMA', N'dbo', 'TABLE', N'KnockOutQuestion', 'COLUMN', N'Ordinal'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Unique identifier for the Questions.', 'SCHEMA', N'dbo', 'TABLE', N'KnockOutQuestion', 'COLUMN', N'QuestionID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The text of the actual question.', 'SCHEMA', N'dbo', 'TABLE', N'KnockOutQuestion', 'COLUMN', N'QuestionText'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The more detailed response typed in by the consumer.', 'SCHEMA', N'dbo', 'TABLE', N'KnockOutQuestion', 'COLUMN', N'ResponseDetail'
GO
