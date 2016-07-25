CREATE TABLE [dbo].[SupplierPolicyStatusIdentifier]
(
[SupplierID] [int] NOT NULL,
[PolicyStatusID] [int] NOT NULL,
[KeyName] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[KeyValue] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[IdentifyingValue] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[PreferenceOrder] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SupplierPolicyStatusIdentifier] ADD CONSTRAINT [PK_SupplierPolicyStatusIdentifier] PRIMARY KEY CLUSTERED  ([SupplierID], [PolicyStatusID], [KeyName], [KeyValue]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SupplierPolicyStatusIdentifier] ADD CONSTRAINT [uc_SupplierPolicyStatusIdentifier] UNIQUE NONCLUSTERED  ([SupplierID], [PolicyStatusID], [PreferenceOrder]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SupplierPolicyStatusIdentifier] ADD CONSTRAINT [FK_SupplierPolicyStatusIdentifier_PolicyStatus] FOREIGN KEY ([PolicyStatusID]) REFERENCES [dbo].[PolicyStatus] ([PolicyStatusID])
GO
ALTER TABLE [dbo].[SupplierPolicyStatusIdentifier] ADD CONSTRAINT [FK_SupplierPolicyStatusIdentifier_SupplierIdentifier] FOREIGN KEY ([SupplierID]) REFERENCES [dbo].[SupplierIdentifier] ([SupplierID])
GO
