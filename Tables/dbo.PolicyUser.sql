CREATE TABLE [dbo].[PolicyUser]
(
[PolicyID] [bigint] NOT NULL,
[UserID] [int] NOT NULL,
[PolicyRoleID] [smallint] NOT NULL,
[New] [bit] NOT NULL,
[CreatedBy] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CreateDate] [datetime] NOT NULL,
[ESignComplete] [bit] NOT NULL CONSTRAINT [DF_PolicyUser_ESigningComplete] DEFAULT ((0)),
[IsOriginalApprover] [bit] NOT NULL CONSTRAINT [DF_PolicyUser_IsOriginalApprover] DEFAULT ((0)),
[SignerStatusID] [int] NOT NULL CONSTRAINT [DF_PolicyUser_SignerStatusID] DEFAULT ((1)),
[SignerStatusDate] [datetime] NULL,
[IsBeingReminded] [bit] NULL CONSTRAINT [DF_PolicyUser_IsRemindered] DEFAULT ((0)),
[PrintCount] [int] NULL,
[RelationRoleCodeId] [int] NULL,
[DocuSignRecipientId] [smallint] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PolicyUser] ADD CONSTRAINT [PK_PolicyUser] PRIMARY KEY CLUSTERED  ([PolicyID], [UserID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_PolicyUser_2] ON [dbo].[PolicyUser] ([UserID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PolicyUser] ADD CONSTRAINT [FK_PolicyUser_Policy] FOREIGN KEY ([PolicyID]) REFERENCES [dbo].[Policy] ([PolicyID])
GO
ALTER TABLE [dbo].[PolicyUser] ADD CONSTRAINT [FK_PolicyUser_PolicyRole] FOREIGN KEY ([PolicyRoleID]) REFERENCES [dbo].[PolicyRole] ([PolicyRoleID])
GO
ALTER TABLE [dbo].[PolicyUser] ADD CONSTRAINT [FK_PolicyUser_RelationRoleCode] FOREIGN KEY ([RelationRoleCodeId]) REFERENCES [dbo].[RelationRoleCode] ([RelationRoleCodeId])
GO
ALTER TABLE [dbo].[PolicyUser] ADD CONSTRAINT [FK_PolicyUser_SignerStatus] FOREIGN KEY ([SignerStatusID]) REFERENCES [dbo].[SignerStatus] ([SignerStatusID])
GO
ALTER TABLE [dbo].[PolicyUser] ADD CONSTRAINT [FK_PolicyUser_User] FOREIGN KEY ([UserID]) REFERENCES [dbo].[User] ([UserID])
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table associates each Policy with 1 or many Users with the role that user plays on that policy (Approver/Reviewer). ', 'SCHEMA', N'dbo', 'TABLE', N'PolicyUser', NULL, NULL
GO
