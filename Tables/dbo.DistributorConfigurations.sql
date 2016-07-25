CREATE TABLE [dbo].[DistributorConfigurations]
(
[DistributorID] [int] NOT NULL,
[ConfigurationKey] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ConfigurationValue] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CreatedBy] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CreateDate] [datetime] NOT NULL,
[ModifiedBy] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ModifiedDate] [datetime] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[DistributorConfigurations] ADD CONSTRAINT [PK_DistributorConfigurations] PRIMARY KEY CLUSTERED  ([DistributorID], [ConfigurationKey]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DistributorConfigurations] ADD CONSTRAINT [FK_DistributorConfigurations_Distributor] FOREIGN KEY ([DistributorID]) REFERENCES [dbo].[Distributor] ([DistributorID])
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table defines any configurations to be set for the Distributor/Customer.', 'SCHEMA', N'dbo', 'TABLE', N'DistributorConfigurations', NULL, NULL
GO
