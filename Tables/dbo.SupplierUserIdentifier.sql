CREATE TABLE [dbo].[SupplierUserIdentifier]
(
[SupplierID] [int] NOT NULL,
[UserID] [int] NOT NULL,
[IdentifyingValue] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CreatedBy] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CreateDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SupplierUserIdentifier] ADD CONSTRAINT [PK_SupplierUserIdentifier] PRIMARY KEY CLUSTERED  ([SupplierID], [UserID], [IdentifyingValue]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_SupplierUserIdentifier_UserID] ON [dbo].[SupplierUserIdentifier] ([UserID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SupplierUserIdentifier] ADD CONSTRAINT [FK_SupplierPolicyEXUserIdentifier_User] FOREIGN KEY ([UserID]) REFERENCES [dbo].[User] ([UserID])
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table defines the User ProducerKey that will be used in the ACORD messages to identify the Users (Agents & Case Manager.  Each carrier has their own codes for a user and sometimes a carrier will have more than 1).  Typically Agents have 1 ProducerID per line of business with a Carrier.', 'SCHEMA', N'dbo', 'TABLE', N'SupplierUserIdentifier', NULL, NULL
GO
