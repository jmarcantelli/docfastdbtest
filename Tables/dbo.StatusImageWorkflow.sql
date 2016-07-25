CREATE TABLE [dbo].[StatusImageWorkflow]
(
[StatusImageWorkflowID] [int] NOT NULL IDENTITY(1, 1),
[StatusImagePolicyUserID] [int] NOT NULL,
[PolicyStatusID] [int] NOT NULL,
[Figure] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CssClass] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[FileName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CCUserFileName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[StatusImageWorkflow] ADD CONSTRAINT [PK_StatusImageWorkflow] PRIMARY KEY CLUSTERED  ([StatusImageWorkflowID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [PolicyStatus] ON [dbo].[StatusImageWorkflow] ([PolicyStatusID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [StatusImagePolicyUser] ON [dbo].[StatusImageWorkflow] ([StatusImagePolicyUserID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[StatusImageWorkflow] ADD CONSTRAINT [FK_StatusImageWorkflow_PolicyStatus] FOREIGN KEY ([PolicyStatusID]) REFERENCES [dbo].[PolicyStatus] ([PolicyStatusID])
GO
ALTER TABLE [dbo].[StatusImageWorkflow] ADD CONSTRAINT [FK_StatusImageWorkflow_StatusImagePolicyUser] FOREIGN KEY ([StatusImagePolicyUserID]) REFERENCES [dbo].[StatusImagePolicyUser] ([StatusImagePolicyUserID])
GO
