CREATE TABLE [dbo].[SupplierTemplates]
(
[SupplierTemplateID] [int] NOT NULL,
[SupplierID] [int] NOT NULL,
[Description] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TemplateXML] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TemplateUniqueID] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CreatedBy] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CreateDate] [datetime] NOT NULL,
[ModifiedBy] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ModifiedDate] [datetime] NOT NULL,
[Active] [bit] NOT NULL CONSTRAINT [DF_SupplierTemplates_Active] DEFAULT ((1)),
[TemplateID] [int] NOT NULL,
[TemplateName] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ProviderFormNumber] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DocumentContents] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DocuSignFields] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Display] [bit] NOT NULL CONSTRAINT [DF_SupplierTemplates_Display] DEFAULT ((1))
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[SupplierTemplates] ADD CONSTRAINT [PK_SupplierTemplates] PRIMARY KEY CLUSTERED  ([SupplierTemplateID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SupplierTemplates] ADD CONSTRAINT [uqc_SupplierID_TemplateID] UNIQUE NONCLUSTERED  ([SupplierID], [TemplateID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SupplierTemplates] ADD CONSTRAINT [FK_SupplierTemplates_SupplierIdentifier] FOREIGN KEY ([SupplierID]) REFERENCES [dbo].[SupplierIdentifier] ([SupplierID])
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table lists the templates defined for each Supplier.  The actual template should be able to be stored in DocuSign  with just a reference here, but we have the flexibility to store the actual template XML as well.', 'SCHEMA', N'dbo', 'TABLE', N'SupplierTemplates', NULL, NULL
GO
