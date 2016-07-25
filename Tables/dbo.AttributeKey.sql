CREATE TABLE [dbo].[AttributeKey]
(
[AttributeKeyId] [smallint] NOT NULL,
[AttributeKeyTypeId] [smallint] NOT NULL,
[AttributeKeyName] [nvarchar] (400) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Description] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AttributeKey] ADD CONSTRAINT [PK_AttributeKey] PRIMARY KEY CLUSTERED  ([AttributeKeyId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AttributeKey] ADD CONSTRAINT [uc_AttributeKey_AttributeKeyName] UNIQUE NONCLUSTERED  ([AttributeKeyName]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AttributeKey] ADD CONSTRAINT [FK_AttributeKey_AttributeKeyType] FOREIGN KEY ([AttributeKeyTypeId]) REFERENCES [dbo].[AttributeKeyType] ([AttributeKeyTypeId])
GO
