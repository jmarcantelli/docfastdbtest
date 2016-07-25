CREATE TABLE [dbo].[PolicyRole]
(
[PolicyRoleID] [smallint] NOT NULL,
[PolicyRoleName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[PolicyRoleCode] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PolicyRole] ADD CONSTRAINT [PK_PolicyRole] PRIMARY KEY CLUSTERED  ([PolicyRoleID]) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_PolicyRoleUnique] ON [dbo].[PolicyRole] ([PolicyRoleID]) ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Descirption', N'This table defines the roles a user can play per policy they are associated with (i.e. Approver, Reviewer)', 'SCHEMA', N'dbo', 'TABLE', N'PolicyRole', NULL, NULL
GO
