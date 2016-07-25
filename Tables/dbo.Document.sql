CREATE TABLE [dbo].[Document]
(
[DocumentID] [bigint] NOT NULL IDENTITY(1, 1),
[DocumentTypeID] [smallint] NOT NULL,
[DocuSignID] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[FileName] [nvarchar] (400) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SupplierTemplateID] [int] NULL,
[CreatedBy] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CreateDate] [datetime] NOT NULL,
[ModifiedBy] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ModifiedDate] [datetime] NULL,
[FileSize] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Document] ADD CONSTRAINT [PK_Document] PRIMARY KEY CLUSTERED  ([DocumentID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Document] ADD CONSTRAINT [FK_Document_DocumentType] FOREIGN KEY ([DocumentTypeID]) REFERENCES [dbo].[DocumentType] ([DocumentTypeID])
GO
ALTER TABLE [dbo].[Document] ADD CONSTRAINT [FK_Document_SupplierTemplates] FOREIGN KEY ([SupplierTemplateID]) REFERENCES [dbo].[SupplierTemplates] ([SupplierTemplateID])
GO
