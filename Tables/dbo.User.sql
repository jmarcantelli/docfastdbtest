CREATE TABLE [dbo].[User]
(
[UserID] [int] NOT NULL IDENTITY(1, 1),
[EmailAddress] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UserTypeID] [smallint] NULL,
[LoginName] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FirstName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[LastName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SupplierID] [int] NULL,
[DistributorID] [int] NULL,
[CreatedBy] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CreateDate] [datetime] NOT NULL,
[Password] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_User_Password] DEFAULT (newid()),
[EffectiveDate] [datetime] NOT NULL CONSTRAINT [DF_User_EffectiveDate] DEFAULT (getdate()),
[ExpirationDate] [datetime] NULL,
[LastLoginDate] [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[User] ADD CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED  ([UserID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[User] ADD CONSTRAINT [ucUserByUserTypeByrDistributor] UNIQUE NONCLUSTERED  ([FirstName], [LastName], [EmailAddress], [UserTypeID], [DistributorID]) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [idx_Unique_LoginName] ON [dbo].[User] ([LoginName]) WHERE ([LoginName] IS NOT NULL) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_UserLoginName] ON [dbo].[User] ([LoginName]) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_PolicyEXUser] ON [dbo].[User] ([UserID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[User] ADD CONSTRAINT [FK_User_Distributor] FOREIGN KEY ([DistributorID]) REFERENCES [dbo].[Distributor] ([DistributorID])
GO
ALTER TABLE [dbo].[User] ADD CONSTRAINT [FK_User_UserType] FOREIGN KEY ([UserTypeID]) REFERENCES [dbo].[UserType] ([UserTypeID])
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table defines all the users (Carrier Case Manager, Distributor Case Managers, Agents & Consumers) who use the PolicyEX system.  Carrier Case Manager, Distributor Case Managers & Agents will be authenticated via PipePass and therefore are required to have a LoginName.  However, Consumers will authenticate with the Policy.UniqueID (in URL they are given) and the PolicyEXUser.AuthetnicationChallengeValue (usually last 4 digits of SSN).', 'SCHEMA', N'dbo', 'TABLE', N'User', NULL, NULL
GO
