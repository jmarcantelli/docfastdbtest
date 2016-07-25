CREATE TABLE [dbo].[PolicyActivityHistory]
(
[PolicyActivityHistoryID] [bigint] NOT NULL IDENTITY(1, 1),
[PolicyID] [bigint] NOT NULL,
[ActivityDate] [datetime] NOT NULL,
[UserID] [int] NULL,
[ConsumerRecipientID] [bigint] NULL,
[PreviousPolicyStatusID] [int] NULL,
[NewPolicyStatusID] [int] NULL,
[IsUserReminded] [bit] NULL,
[ActionID] [smallint] NULL,
[ActionTargetUserID] [int] NULL,
[ActionTargetConsumerID] [bigint] NULL,
[LanguageId] [smallint] NULL,
[BrowserName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BrowserVersion] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BrowserPlatform] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsMobileDevice] [bit] NULL,
[MobileDeviceModel] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MobileDeviceManufacturer] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UserAgent] [nvarchar] (4000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UserHostAddress] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CreatedBy] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PolicyActivityHistory] ADD CONSTRAINT [PK_PolicyActivityHistory] PRIMARY KEY CLUSTERED  ([PolicyActivityHistoryID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_PolicyActivityHistory_11] ON [dbo].[PolicyActivityHistory] ([PolicyID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PolicyActivityHistory] ADD CONSTRAINT [FK_PolicyActivityHistory_Action] FOREIGN KEY ([ActionID]) REFERENCES [dbo].[Action] ([ActionID])
GO
ALTER TABLE [dbo].[PolicyActivityHistory] ADD CONSTRAINT [FK_PolicyActivityHistory_ActionTargetUser] FOREIGN KEY ([ActionTargetUserID]) REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[PolicyActivityHistory] ADD CONSTRAINT [FK_PolicyActivityHistory_Language] FOREIGN KEY ([LanguageId]) REFERENCES [dbo].[Language] ([LanguageId])
GO
ALTER TABLE [dbo].[PolicyActivityHistory] ADD CONSTRAINT [FK_PolicyActivityHistory_Policy] FOREIGN KEY ([PolicyID]) REFERENCES [dbo].[Policy] ([PolicyID])
GO
ALTER TABLE [dbo].[PolicyActivityHistory] ADD CONSTRAINT [FK_PolicyActivityHistory_PolicyStatus] FOREIGN KEY ([PreviousPolicyStatusID]) REFERENCES [dbo].[PolicyStatus] ([PolicyStatusID])
GO
ALTER TABLE [dbo].[PolicyActivityHistory] ADD CONSTRAINT [FK_PolicyActivityHistory_PolicyStatus1] FOREIGN KEY ([NewPolicyStatusID]) REFERENCES [dbo].[PolicyStatus] ([PolicyStatusID])
GO
ALTER TABLE [dbo].[PolicyActivityHistory] ADD CONSTRAINT [FK_PolicyActivityHistory_User] FOREIGN KEY ([UserID]) REFERENCES [dbo].[User] ([UserID])
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table is a history of all the actions, status changes, etc. that occured on a Policy.  Status changes will have the previous & new status listed, but some activities listed won''t change the status, which will leave those fields null.', 'SCHEMA', N'dbo', 'TABLE', N'PolicyActivityHistory', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Name of the browser used by the user for taking the action', 'SCHEMA', N'dbo', 'TABLE', N'PolicyActivityHistory', 'COLUMN', N'BrowserName'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Version of the browser used by the user for taking the action', 'SCHEMA', N'dbo', 'TABLE', N'PolicyActivityHistory', 'COLUMN', N'BrowserVersion'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Browser language used by the user at the time of taking the action', 'SCHEMA', N'dbo', 'TABLE', N'PolicyActivityHistory', 'COLUMN', N'LanguageId'
GO
