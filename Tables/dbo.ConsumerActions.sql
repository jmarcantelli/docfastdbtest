CREATE TABLE [dbo].[ConsumerActions]
(
[ConsumerActionID] [int] NOT NULL IDENTITY(1, 1),
[PolicyStatusID] [int] NOT NULL,
[SignerStatusID] [int] NOT NULL,
[RelationRoleCodeID] [int] NULL,
[ActionID] [smallint] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ConsumerActions] ADD CONSTRAINT [PK_ConsumerActions] PRIMARY KEY CLUSTERED  ([ConsumerActionID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ConsumerActions] ADD CONSTRAINT [FK_ConsumerActions_Action] FOREIGN KEY ([ActionID]) REFERENCES [dbo].[Action] ([ActionID])
GO
ALTER TABLE [dbo].[ConsumerActions] ADD CONSTRAINT [FK_ConsumerActions_PolicyStatus] FOREIGN KEY ([PolicyStatusID]) REFERENCES [dbo].[PolicyStatus] ([PolicyStatusID])
GO
ALTER TABLE [dbo].[ConsumerActions] ADD CONSTRAINT [FK_ConsumerActions_RelationRoleCode] FOREIGN KEY ([RelationRoleCodeID]) REFERENCES [dbo].[RelationRoleCode] ([RelationRoleCodeId])
GO
