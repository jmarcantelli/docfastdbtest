CREATE TABLE [dbo].[PolicyDistributor]
(
[PolicyID] [bigint] NOT NULL,
[DistributorID] [int] NOT NULL,
[CreatedBy] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CreateDate] [datetime] NOT NULL,
[DistributionOrder] [smallint] NOT NULL CONSTRAINT [DF_PolicyDistributor_DistributionOrder] DEFAULT ((1)),
[OriginalDistributor] [bit] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PolicyDistributor] ADD CONSTRAINT [PK_PolicyDistributor] PRIMARY KEY CLUSTERED  ([PolicyID], [DistributorID], [DistributionOrder]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PolicyDistributor] ADD CONSTRAINT [FK_PolicyDistributor_Distributor] FOREIGN KEY ([DistributorID]) REFERENCES [dbo].[Distributor] ([DistributorID])
GO
ALTER TABLE [dbo].[PolicyDistributor] ADD CONSTRAINT [FK_PolicyDistributor_Policy] FOREIGN KEY ([PolicyID]) REFERENCES [dbo].[Policy] ([PolicyID])
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table associates each Policy with 1 or many Distrobutors.  The original  Distributor must be flagged since all communication to the Carrier/Supplier must be on behalf of the original Distributor.', 'SCHEMA', N'dbo', 'TABLE', N'PolicyDistributor', NULL, NULL
GO
