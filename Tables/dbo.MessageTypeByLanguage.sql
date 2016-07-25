CREATE TABLE [dbo].[MessageTypeByLanguage]
(
[MessageTypeID] [int] NOT NULL,
[LanguageID] [smallint] NOT NULL,
[DisplayName] [nvarchar] (400) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MessageTypeByLanguage] ADD CONSTRAINT [PK_MessageTypeByLanguage] PRIMARY KEY CLUSTERED  ([MessageTypeID], [LanguageID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MessageTypeByLanguage] ADD CONSTRAINT [FK_MessageTypeByLanguage_Language] FOREIGN KEY ([LanguageID]) REFERENCES [dbo].[Language] ([LanguageId])
GO
ALTER TABLE [dbo].[MessageTypeByLanguage] ADD CONSTRAINT [FK_MessageTypeByLanguage_MessageType] FOREIGN KEY ([MessageTypeID]) REFERENCES [dbo].[MessageType] ([MessageTypeID])
GO
