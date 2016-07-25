CREATE TABLE [dbo].[SignerStatusByLanguage]
(
[SignerStatusID] [int] NOT NULL,
[LanguageID] [smallint] NOT NULL,
[SignerStatusName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SignerStatusByLanguage] ADD CONSTRAINT [PK_SignerStatusByLanguage] PRIMARY KEY CLUSTERED  ([SignerStatusID], [LanguageID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SignerStatusByLanguage] ADD CONSTRAINT [FK_SignerStatusByLanguage_Language] FOREIGN KEY ([LanguageID]) REFERENCES [dbo].[Language] ([LanguageId])
GO
ALTER TABLE [dbo].[SignerStatusByLanguage] ADD CONSTRAINT [FK_SignerStatusByLanguage_SignerStatus] FOREIGN KEY ([SignerStatusID]) REFERENCES [dbo].[SignerStatus] ([SignerStatusID])
GO
ALTER TABLE [dbo].[SignerStatusByLanguage] ADD CONSTRAINT [FK_SignerStatusByLanguage_SignerStatusByLanguage] FOREIGN KEY ([SignerStatusID], [LanguageID]) REFERENCES [dbo].[SignerStatusByLanguage] ([SignerStatusID], [LanguageID])
GO
