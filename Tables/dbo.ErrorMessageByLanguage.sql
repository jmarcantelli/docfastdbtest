CREATE TABLE [dbo].[ErrorMessageByLanguage]
(
[ErrorMessageID] [int] NOT NULL,
[LanguageID] [smallint] NOT NULL,
[Message] [nvarchar] (4000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ErrorMessageByLanguage] ADD CONSTRAINT [PK_ErrorMessageByLanguage] PRIMARY KEY CLUSTERED  ([ErrorMessageID], [LanguageID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ErrorMessageByLanguage] ADD CONSTRAINT [FK_ErrorMessageByLanguage_ErrorMessage] FOREIGN KEY ([ErrorMessageID]) REFERENCES [dbo].[ErrorMessage] ([ErrorMessageID])
GO
ALTER TABLE [dbo].[ErrorMessageByLanguage] ADD CONSTRAINT [FK_ErrorMessageByLanguage_ErrorMessageByLanguage] FOREIGN KEY ([ErrorMessageID], [LanguageID]) REFERENCES [dbo].[ErrorMessageByLanguage] ([ErrorMessageID], [LanguageID])
GO
ALTER TABLE [dbo].[ErrorMessageByLanguage] ADD CONSTRAINT [FK_ErrorMessageByLanguage_Language] FOREIGN KEY ([LanguageID]) REFERENCES [dbo].[Language] ([LanguageId])
GO
