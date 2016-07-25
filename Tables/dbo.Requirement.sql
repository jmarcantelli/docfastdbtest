CREATE TABLE [dbo].[Requirement]
(
[RequirementID] [bigint] NOT NULL IDENTITY(1, 1),
[PolicyID] [bigint] NOT NULL,
[ConsumerRecipientID] [bigint] NULL,
[AttachmentID] [bigint] NULL,
[RequirementCode] [int] NOT NULL,
[Description] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RequestedDate] [datetime] NULL,
[DueDate] [datetime] NULL,
[RequirementExternalID] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Requirement] ADD CONSTRAINT [PK_Requirement] PRIMARY KEY CLUSTERED  ([RequirementID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Requirement] ADD CONSTRAINT [FK_Requirement_ConsumerRecipient] FOREIGN KEY ([ConsumerRecipientID]) REFERENCES [dbo].[ConsumerRecipient] ([ConsumerRecipientID])
GO
ALTER TABLE [dbo].[Requirement] ADD CONSTRAINT [FK_Requirement_Policy] FOREIGN KEY ([PolicyID]) REFERENCES [dbo].[Policy] ([PolicyID])
GO
ALTER TABLE [dbo].[Requirement] ADD CONSTRAINT [FK_Requirement_PolicyAttachment] FOREIGN KEY ([AttachmentID]) REFERENCES [dbo].[PolicyAttachment] ([AttachmentID])
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table defines the Requirement associated to a Policy by Consumer/User.', 'SCHEMA', N'dbo', 'TABLE', N'Requirement', NULL, NULL
GO
