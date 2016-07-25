CREATE TABLE [dbo].[DocumentFieldValueList]
(
[DocumentFieldValueListId] [int] NOT NULL,
[DocumentFieldMappingId] [int] NOT NULL,
[FieldValue] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[IsDefault] [bit] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DocumentFieldValueList] ADD CONSTRAINT [PK_DocumentFieldValueList] PRIMARY KEY CLUSTERED  ([DocumentFieldValueListId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DocumentFieldValueList] ADD CONSTRAINT [uc_DocumentFieldMappingId_FieldValue] UNIQUE NONCLUSTERED  ([DocumentFieldMappingId], [FieldValue]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DocumentFieldValueList] ADD CONSTRAINT [FK_DocumentFieldValueList_DocumentFieldMapping] FOREIGN KEY ([DocumentFieldMappingId]) REFERENCES [dbo].[DocumentFieldMapping] ([DocumentFieldMappingId])
GO
