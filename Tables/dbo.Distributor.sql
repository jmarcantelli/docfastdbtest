CREATE TABLE [dbo].[Distributor]
(
[DistributorID] [int] NOT NULL,
[Name] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CustomerID] [int] NULL,
[PipePassSiteID] [int] NULL,
[DistributorTypeID] [smallint] NOT NULL,
[CreatedBy] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CreateDate] [datetime] NOT NULL,
[PipePassPolicyEXUserGroupID] [int] NULL,
[Active] [bit] NOT NULL CONSTRAINT [DF__Distribut__Activ__75392FF8] DEFAULT ((1))
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Distributor] ADD CONSTRAINT [PK_Distributor] PRIMARY KEY CLUSTERED  ([DistributorID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Distributor] ADD CONSTRAINT [FK_Distributor_DistributorType] FOREIGN KEY ([DistributorTypeID]) REFERENCES [dbo].[DistributorType] ([DistributorTypeID])
GO
