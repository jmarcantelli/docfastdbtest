CREATE TABLE [dbo].[PolicyAttachment]
(
[AttachmentID] [bigint] NOT NULL IDENTITY(1, 1),
[PolicyID] [bigint] NOT NULL,
[MimeTypeTC] [int] NOT NULL,
[FileName] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DisplayOrder] [int] NOT NULL,
[ACORDAttachmentTypeTC] [int] NULL,
[SupplierTemplateID] [int] NULL,
[CreatedBy] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CreateDate] [datetime] NOT NULL,
[ModifiedBy] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ModifiedDate] [datetime] NOT NULL,
[TemplateXML] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TXLifeAttachmentID] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PolicyAttachmentID] [smallint] NULL,
[SignedDocument] [bit] NULL,
[ProviderFormNumber] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FileSize] [int] NULL,
[ProviderAttachment] [bit] NOT NULL CONSTRAINT [DF__PolicyAtt__Provi__52AF0DCA] DEFAULT ((1))
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[PolicyAttachment] ADD CONSTRAINT [PK_PolicyAttachment] PRIMARY KEY CLUSTERED  ([AttachmentID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IDX_PolicyAttachment_7] ON [dbo].[PolicyAttachment] ([PolicyID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PolicyAttachment] ADD CONSTRAINT [FK_PolicyAttachment_Policy] FOREIGN KEY ([PolicyID]) REFERENCES [dbo].[Policy] ([PolicyID]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PolicyAttachment] ADD CONSTRAINT [FK_PolicyAttachment_SupplierTemplates] FOREIGN KEY ([SupplierTemplateID]) REFERENCES [dbo].[SupplierTemplates] ([SupplierTemplateID])
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table lists all the documents associated with the Policy with their IDs in DocuSign, templates, etc.', 'SCHEMA', N'dbo', 'TABLE', N'PolicyAttachment', NULL, NULL
GO
