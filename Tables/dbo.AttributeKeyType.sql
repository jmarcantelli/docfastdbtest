CREATE TABLE [dbo].[AttributeKeyType]
(
[AttributeKeyTypeId] [smallint] NOT NULL,
[AttributeKeyTypeName] [nvarchar] (400) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AttributeKeyType] ADD CONSTRAINT [PK_AttributeKeyType] PRIMARY KEY CLUSTERED  ([AttributeKeyTypeId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AttributeKeyType] ADD CONSTRAINT [uc_AttributeKeyType_AttributeKeyTypeName] UNIQUE NONCLUSTERED  ([AttributeKeyTypeName]) ON [PRIMARY]
GO
