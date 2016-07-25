CREATE TABLE [dbo].[ProductType]
(
[ProductTypeID] [smallint] NOT NULL,
[ProductTypeCode] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ProductTypeName] [nvarchar] (125) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Description] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ActiveFlag] [bit] NOT NULL,
[CreatedBy] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ModifiedBy] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CreateDate] [datetime] NULL CONSTRAINT [DF__ProductType__CreateDate__49C3F6B7] DEFAULT (getdate()),
[ModifiedDate] [datetime] NULL CONSTRAINT [DF_ProductType_ModifiedDate] DEFAULT (getdate()),
[CodeValueID] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ProductType] ADD CONSTRAINT [ProductType_PK] PRIMARY KEY NONCLUSTERED  ([ProductTypeID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ProductType] ADD CONSTRAINT [UC_ProductTypeCode] UNIQUE NONCLUSTERED  ([ProductTypeCode]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ProductType] ADD CONSTRAINT [UC_ProductTypeName] UNIQUE NONCLUSTERED  ([ProductTypeName]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ProductType] ADD CONSTRAINT [FK_ProductType_CodeValue] FOREIGN KEY ([CodeValueID]) REFERENCES [dbo].[CodeValue] ([CodeValueID])
GO
EXEC sp_addextendedproperty N'MS_Description', N'ProductTypes define classes of Products.  The Name here is the default supplied by iPipeline. Maintained in AdminPipe. Maintained by iPipeline Administrators.', 'SCHEMA', N'dbo', 'TABLE', N'ProductType', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Indicates this ProductType is active in applications', 'SCHEMA', N'dbo', 'TABLE', N'ProductType', 'COLUMN', N'ActiveFlag'
GO
EXEC sp_addextendedproperty N'MS_Description', N'iPipeline description of ProductType', 'SCHEMA', N'dbo', 'TABLE', N'ProductType', 'COLUMN', N'Description'
GO
EXEC sp_addextendedproperty N'MS_Description', N'ProductTypeID identifies ProductType', 'SCHEMA', N'dbo', 'TABLE', N'ProductType', 'COLUMN', N'ProductTypeID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'iPipeline name of ProductType', 'SCHEMA', N'dbo', 'TABLE', N'ProductType', 'COLUMN', N'ProductTypeName'
GO
