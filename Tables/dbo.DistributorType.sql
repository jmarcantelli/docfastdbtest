CREATE TABLE [dbo].[DistributorType]
(
[DistributorTypeID] [smallint] NOT NULL,
[Description] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DistributorType] ADD CONSTRAINT [PK_DistributorType] PRIMARY KEY CLUSTERED  ([DistributorTypeID]) ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a list of the types of distributors who can be in the system (BGA, Direct Writers, Carrier)', 'SCHEMA', N'dbo', 'TABLE', N'DistributorType', NULL, NULL
GO
