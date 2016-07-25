CREATE TABLE [dbo].[SignerSequenceRole]
(
[SignerSequenceRoleID] [int] NOT NULL IDENTITY(1, 1),
[SignerSequenceID] [int] NOT NULL,
[RelationRoleCodeID] [int] NOT NULL,
[Sequence] [smallint] NOT NULL CONSTRAINT [DF_SignerSequenceRole_Sequence] DEFAULT ((1))
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SignerSequenceRole] ADD CONSTRAINT [PK_SignerSequenceRole] PRIMARY KEY CLUSTERED  ([SignerSequenceRoleID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_SignerSequenceRole] ON [dbo].[SignerSequenceRole] ([SignerSequenceID], [RelationRoleCodeID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SignerSequenceRole] ADD CONSTRAINT [FK_SignerSequenceRole_RelationRoleCode] FOREIGN KEY ([RelationRoleCodeID]) REFERENCES [dbo].[RelationRoleCode] ([RelationRoleCodeId])
GO
ALTER TABLE [dbo].[SignerSequenceRole] ADD CONSTRAINT [FK_SignerSequenceRole_SignerSequence] FOREIGN KEY ([SignerSequenceID]) REFERENCES [dbo].[SignerSequence] ([SignerSequenceID])
GO
