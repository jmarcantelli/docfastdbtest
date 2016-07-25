CREATE TABLE [dbo].[PolicyBeneficiary]
(
[BeneficiaryID] [bigint] NOT NULL IDENTITY(1, 1),
[PolicyID] [bigint] NOT NULL,
[RelationRoleCodeId] [int] NOT NULL,
[ParticipationPercent] [decimal] (18, 0) NULL,
[IrrevokableInd] [bit] NULL,
[IsPrimary] [bit] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PolicyBeneficiary] ADD CONSTRAINT [PK_PolicyBenificiary] PRIMARY KEY CLUSTERED  ([BeneficiaryID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PolicyBeneficiary] ADD CONSTRAINT [FK_PolicyBenificiary_Policy] FOREIGN KEY ([PolicyID]) REFERENCES [dbo].[Policy] ([PolicyID])
GO
ALTER TABLE [dbo].[PolicyBeneficiary] ADD CONSTRAINT [FK_PolicyBenificiary_RelationRoleCode] FOREIGN KEY ([RelationRoleCodeId]) REFERENCES [dbo].[CodeValue] ([CodeValueID])
GO
EXEC sp_addextendedproperty N'MS_Description', N'A list of the benificiaries associated to a policy.', 'SCHEMA', N'dbo', 'TABLE', N'PolicyBeneficiary', NULL, NULL
GO
