CREATE TABLE [dbo].[PolicyStatus]
(
[PolicyStatusID] [int] NOT NULL,
[PolicyStatusName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PolicyStatusCode] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PolicyStatus] ADD CONSTRAINT [PK_Status] PRIMARY KEY CLUSTERED  ([PolicyStatusID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PolicyStatus] ADD CONSTRAINT [uqc_PolicyStatusCode] UNIQUE NONCLUSTERED  ([PolicyStatusCode]) ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table lists all the possible statuses of a policy in the system.', 'SCHEMA', N'dbo', 'TABLE', N'PolicyStatus', NULL, NULL
GO
