CREATE TABLE [dbo].[DashboardActions]
(
[DashboardActionID] [int] NOT NULL IDENTITY(1, 1),
[UserTypeID] [smallint] NOT NULL,
[PolicyStatusID] [int] NOT NULL,
[PolicyRoleID] [smallint] NOT NULL,
[ActionID] [smallint] NOT NULL,
[PolicyDeliveryTypeID] [smallint] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DashboardActions] ADD CONSTRAINT [PK_DashboardActions] PRIMARY KEY CLUSTERED  ([DashboardActionID]) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_DashboardActions] ON [dbo].[DashboardActions] ([DashboardActionID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DashboardActions] ADD CONSTRAINT [FK_DashboardActions_Action] FOREIGN KEY ([ActionID]) REFERENCES [dbo].[Action] ([ActionID])
GO
ALTER TABLE [dbo].[DashboardActions] ADD CONSTRAINT [FK_DashboardActions_PolicyRole] FOREIGN KEY ([PolicyRoleID]) REFERENCES [dbo].[PolicyRole] ([PolicyRoleID])
GO
ALTER TABLE [dbo].[DashboardActions] ADD CONSTRAINT [FK_DashboardActions_PolicyStatus] FOREIGN KEY ([PolicyStatusID]) REFERENCES [dbo].[PolicyStatus] ([PolicyStatusID])
GO
ALTER TABLE [dbo].[DashboardActions] ADD CONSTRAINT [FK_DashboardActions_UserType] FOREIGN KEY ([UserTypeID]) REFERENCES [dbo].[UserType] ([UserTypeID])
GO
