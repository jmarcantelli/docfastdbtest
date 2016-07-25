CREATE TABLE [dbo].[PolicyAlertByLanguage]
(
[PolicyAlertID] [bigint] NOT NULL,
[LanguageID] [smallint] NOT NULL,
[AlertText] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[PolicyAlertByLanguage] ADD CONSTRAINT [PK_PolicyAlertByLanguage] PRIMARY KEY CLUSTERED  ([PolicyAlertID], [LanguageID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PolicyAlertByLanguage] ADD CONSTRAINT [FK_PolicyAlertByLanguage_Language] FOREIGN KEY ([LanguageID]) REFERENCES [dbo].[Language] ([LanguageId])
GO
ALTER TABLE [dbo].[PolicyAlertByLanguage] ADD CONSTRAINT [FK_PolicyAlertByLanguage_PolicyAlert] FOREIGN KEY ([PolicyAlertID]) REFERENCES [dbo].[PolicyAlert] ([PolicyAlertID])
GO
