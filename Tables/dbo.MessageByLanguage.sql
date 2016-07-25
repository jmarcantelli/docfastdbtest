CREATE TABLE [dbo].[MessageByLanguage]
(
[MessageID] [int] NOT NULL,
[LanguageID] [smallint] NOT NULL,
[MessageValue] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[MessageByLanguage] ADD CONSTRAINT [PK_MessageByLanguage] PRIMARY KEY CLUSTERED  ([MessageID], [LanguageID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MessageByLanguage] ADD CONSTRAINT [FK_MessageByLanguage_Language] FOREIGN KEY ([LanguageID]) REFERENCES [dbo].[Language] ([LanguageId])
GO
ALTER TABLE [dbo].[MessageByLanguage] ADD CONSTRAINT [FK_MessageByLanguage_Message] FOREIGN KEY ([MessageID]) REFERENCES [dbo].[Message] ([MessageID])
GO
