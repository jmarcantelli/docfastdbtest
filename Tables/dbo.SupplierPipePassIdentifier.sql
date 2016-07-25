CREATE TABLE [dbo].[SupplierPipePassIdentifier]
(
[SupplierID] [int] NOT NULL,
[SiteID] [int] NOT NULL,
[CreatedBy] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CreateDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SupplierPipePassIdentifier] ADD CONSTRAINT [PK_SupplierPipePassIdentifier] PRIMARY KEY CLUSTERED  ([SupplierID]) ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table defines the PipePass ID for the Supplier in order to associate PipePass settings, Users, etc.', 'SCHEMA', N'dbo', 'TABLE', N'SupplierPipePassIdentifier', NULL, NULL
GO
