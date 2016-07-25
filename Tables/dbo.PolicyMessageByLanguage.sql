CREATE TABLE [dbo].[PolicyMessageByLanguage]
(
[PolicyMessageID] [bigint] NOT NULL,
[LanguageID] [smallint] NOT NULL,
[MessageText] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[PolicyMessageByLanguage] ADD CONSTRAINT [PK_PolicyMessageByLanguage] PRIMARY KEY CLUSTERED  ([PolicyMessageID], [LanguageID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PolicyMessageByLanguage] ADD CONSTRAINT [FK_PolicyMessageByLanguage_Language] FOREIGN KEY ([LanguageID]) REFERENCES [dbo].[Language] ([LanguageId])
GO
ALTER TABLE [dbo].[PolicyMessageByLanguage] ADD CONSTRAINT [FK_PolicyMessageByLanguage_Message] FOREIGN KEY ([PolicyMessageID]) REFERENCES [dbo].[PolicyMessage] ([PolicyMessageID])
GO
