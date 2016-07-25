CREATE TABLE [dbo].[ConsumerRecipient]
(
[ConsumerRecipientID] [bigint] NOT NULL IDENTITY(1, 1),
[PolicyID] [bigint] NOT NULL,
[FirstName] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[LastName] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[EmailAddress] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[AuthenticationChallengeValue] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UniqueID] [uniqueidentifier] NULL,
[UniqueFailCount] [tinyint] NULL,
[DocuSignStatusID] [smallint] NULL,
[PaymentInfo] [xml] NULL,
[PaymentAmount] [money] NULL,
[PremiumAmount] [money] NULL,
[PaymentModeID] [smallint] NULL,
[Active] [bit] NOT NULL CONSTRAINT [ConsumerRecipient_Active_Default] DEFAULT ((1)),
[RequireDocuSignIDCheck] [bit] NOT NULL CONSTRAINT [DF_ConsumerRecipient_RequireIDCheck] DEFAULT ((0)),
[TemplateRoleName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PrimaryConsumer] [bit] NOT NULL CONSTRAINT [DF_ConsumerRecipient_Active1] DEFAULT ((1)),
[ESignComplete] [bit] NOT NULL CONSTRAINT [DF_ConsumerRecipient_ESignComplete] DEFAULT ((0)),
[SignerStatusID] [int] NOT NULL CONSTRAINT [DF_ConsumerRecipient_SignerStatusID] DEFAULT ((1)),
[SignerStatusDate] [datetime] NULL,
[BusinessName] [nvarchar] (300) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ExpiryDate] [datetime] NULL,
[ConsumerCarrierID] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RequireConsumerQuiz] [bit] NULL,
[FaceToFace] [bit] NOT NULL CONSTRAINT [DF__ConsumerR__FaceT__74A4331B] DEFAULT ((0)),
[RelationRoleCodeId] [int] NULL,
[BirthDate] [datetime] NULL,
[MaritalStatusCodeId] [int] NULL,
[DocuSignRecipientId] [smallint] NULL,
[SigningSequence] [smallint] NOT NULL CONSTRAINT [DF__ConsumerR__Signi__02732F85] DEFAULT ((1))
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[ConsumerRecipient] ADD CONSTRAINT [PK_ConsumerRecipient] PRIMARY KEY CLUSTERED  ([ConsumerRecipientID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_ConsumerRecipient] ON [dbo].[ConsumerRecipient] ([ConsumerRecipientID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_ConsumerRecipient_PolicyID] ON [dbo].[ConsumerRecipient] ([PolicyID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ConsumerRecipient] ADD CONSTRAINT [ConsumerRecipient_UniqueUniqueID] UNIQUE NONCLUSTERED  ([UniqueID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ConsumerRecipient] ADD CONSTRAINT [FK_ConsumerRecipient_MarStat] FOREIGN KEY ([MaritalStatusCodeId]) REFERENCES [dbo].[CodeValue] ([CodeValueID])
GO
ALTER TABLE [dbo].[ConsumerRecipient] ADD CONSTRAINT [FK_ConsumerRecipient_PaymentMode] FOREIGN KEY ([PaymentModeID]) REFERENCES [dbo].[PaymentMode] ([PaymentModeID])
GO
ALTER TABLE [dbo].[ConsumerRecipient] ADD CONSTRAINT [FK_ConsumerRecipient_Policy] FOREIGN KEY ([PolicyID]) REFERENCES [dbo].[Policy] ([PolicyID])
GO
ALTER TABLE [dbo].[ConsumerRecipient] ADD CONSTRAINT [FK_ConsumerRecipient_RelationRoleCode] FOREIGN KEY ([RelationRoleCodeId]) REFERENCES [dbo].[RelationRoleCode] ([RelationRoleCodeId])
GO
ALTER TABLE [dbo].[ConsumerRecipient] ADD CONSTRAINT [FK_ConsumerRecipient_SignerStatus] FOREIGN KEY ([SignerStatusID]) REFERENCES [dbo].[SignerStatus] ([SignerStatusID])
GO
EXEC sp_addextendedproperty N'MS_Description', N'This flag indicates if the ConsumerRecipient is currently active.', 'SCHEMA', N'dbo', 'TABLE', N'ConsumerRecipient', 'COLUMN', N'Active'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This flag indicates if the ConsumerRecipient is currently active.', 'SCHEMA', N'dbo', 'TABLE', N'ConsumerRecipient', 'COLUMN', N'PrimaryConsumer'
GO
