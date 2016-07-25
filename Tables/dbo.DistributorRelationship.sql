CREATE TABLE [dbo].[DistributorRelationship]
(
[ParentDistributorID] [int] NOT NULL,
[ChildDistributorID] [int] NOT NULL,
[CreatedBy] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CreateDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DistributorRelationship] ADD CONSTRAINT [PK_DistributorRelationship] PRIMARY KEY CLUSTERED  ([ParentDistributorID], [ChildDistributorID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DistributorRelationship] ADD CONSTRAINT [FK_DistributorRelationship_Distributor] FOREIGN KEY ([ParentDistributorID]) REFERENCES [dbo].[Distributor] ([DistributorID])
GO
ALTER TABLE [dbo].[DistributorRelationship] ADD CONSTRAINT [FK_DistributorRelationship_Distributor1] FOREIGN KEY ([ChildDistributorID]) REFERENCES [dbo].[Distributor] ([DistributorID])
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table defines a relationship between two distributors (i.e. SubGAs).  Distributors who have SubGAs are allowed to transfer/share cases to their SubGA & vice versa.', 'SCHEMA', N'dbo', 'TABLE', N'DistributorRelationship', NULL, NULL
GO
