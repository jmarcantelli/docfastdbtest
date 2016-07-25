CREATE TABLE [dbo].[AlertCriteria]
(
[AlertCriteriaID] [int] NOT NULL,
[AlertTypeID] [int] NOT NULL,
[UserTypeID] [smallint] NULL,
[PolicyRoleID] [smallint] NULL,
[PolicyStatusID] [int] NULL,
[AlertRating] [smallint] NULL,
[AlertText] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DeliveryDateWithin] [smallint] NULL,
[NewFlag] [bit] NULL,
[ExtensionRequest] [bit] NULL,
[SignerStatusID] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[AlertCriteria] ADD CONSTRAINT [PK_AlertCondition] PRIMARY KEY CLUSTERED  ([AlertCriteriaID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AlertCriteria] ADD CONSTRAINT [FK_AlertCriteria_AlertType] FOREIGN KEY ([AlertTypeID]) REFERENCES [dbo].[AlertType] ([AlertTypeID])
GO
ALTER TABLE [dbo].[AlertCriteria] ADD CONSTRAINT [FK_AlertCriteria_PolicyRole] FOREIGN KEY ([PolicyRoleID]) REFERENCES [dbo].[PolicyRole] ([PolicyRoleID])
GO
ALTER TABLE [dbo].[AlertCriteria] ADD CONSTRAINT [FK_AlertCriteria_PolicyStatus] FOREIGN KEY ([PolicyStatusID]) REFERENCES [dbo].[PolicyStatus] ([PolicyStatusID])
GO
ALTER TABLE [dbo].[AlertCriteria] ADD CONSTRAINT [FK_AlertCriteria_UserType] FOREIGN KEY ([UserTypeID]) REFERENCES [dbo].[UserType] ([UserTypeID])
GO
EXEC sp_addextendedproperty N'MS_Description', N'Alert Importance Rating', 'SCHEMA', N'dbo', 'TABLE', N'AlertCriteria', 'COLUMN', N'AlertRating'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Delivery Date is within a specified number of days, the alert should trigger', 'SCHEMA', N'dbo', 'TABLE', N'AlertCriteria', 'COLUMN', N'DeliveryDateWithin'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Role of the current user on the  policy', 'SCHEMA', N'dbo', 'TABLE', N'AlertCriteria', 'COLUMN', N'PolicyRoleID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Current Status of the Policy', 'SCHEMA', N'dbo', 'TABLE', N'AlertCriteria', 'COLUMN', N'PolicyStatusID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'User Type of the Current Logged on User', 'SCHEMA', N'dbo', 'TABLE', N'AlertCriteria', 'COLUMN', N'UserTypeID'
GO
