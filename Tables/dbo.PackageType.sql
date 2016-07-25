CREATE TABLE [dbo].[PackageType]
(
[PackageTypeID] [smallint] NOT NULL,
[PackageTypeCode] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[PackageTypeName] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Description] [nvarchar] (400) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ActiveFlag] [bit] NOT NULL,
[CreatedBy] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ModifiedBy] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CreateDate] [datetime] NULL CONSTRAINT [DF__PackageType__CreateDate__49C3F6B7] DEFAULT (getdate()),
[ModifiedDate] [datetime] NULL CONSTRAINT [DF_PackageType_ModifiedDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PackageType] ADD CONSTRAINT [PackageType_PK] PRIMARY KEY NONCLUSTERED  ([PackageTypeID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PackageType] ADD CONSTRAINT [UC_PackageTypeCode] UNIQUE NONCLUSTERED  ([PackageTypeCode]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PackageType] ADD CONSTRAINT [UC_PackageTypeName] UNIQUE NONCLUSTERED  ([PackageTypeName]) ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'PackageTypes define classes of Packages.  The Name here is the default supplied by iPipeline. Maintained in AdminPipe. Maintained by iPipeline Administrators.', 'SCHEMA', N'dbo', 'TABLE', N'PackageType', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Indicates this PackageType is active in applications', 'SCHEMA', N'dbo', 'TABLE', N'PackageType', 'COLUMN', N'ActiveFlag'
GO
EXEC sp_addextendedproperty N'MS_Description', N'iPipeline description of PackageType', 'SCHEMA', N'dbo', 'TABLE', N'PackageType', 'COLUMN', N'Description'
GO
EXEC sp_addextendedproperty N'MS_Description', N'PackageTypeID identifies PackageType', 'SCHEMA', N'dbo', 'TABLE', N'PackageType', 'COLUMN', N'PackageTypeID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'iPipeline name of PackageType', 'SCHEMA', N'dbo', 'TABLE', N'PackageType', 'COLUMN', N'PackageTypeName'
GO
