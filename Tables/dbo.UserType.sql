CREATE TABLE [dbo].[UserType]
(
[UserTypeID] [smallint] NOT NULL,
[UserTypeName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[UserType] ADD CONSTRAINT [PK_UserType] PRIMARY KEY CLUSTERED  ([UserTypeID]) ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table defines the types of users in the PolicyEX system (i.e. Carrier Case Manager, Distributor Case Manager, Agent, Pending Distributor Case Manager, Peniding Agent)', 'SCHEMA', N'dbo', 'TABLE', N'UserType', NULL, NULL
GO
