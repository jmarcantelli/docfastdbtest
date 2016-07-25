CREATE TABLE [dbo].[DocumentType]
(
[DocumentTypeID] [smallint] NOT NULL,
[DocumentTypeName] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Description] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DocumentTypeCode] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DocumentType] ADD CONSTRAINT [PK_DocumentType] PRIMARY KEY CLUSTERED  ([DocumentTypeID]) ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a list of Document Types than can be uploaded in the system (Lab Results etc)', 'SCHEMA', N'dbo', 'TABLE', N'DocumentType', NULL, NULL
GO
