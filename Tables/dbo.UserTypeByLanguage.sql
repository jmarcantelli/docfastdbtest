CREATE TABLE [dbo].[UserTypeByLanguage]
(
[UserTypeID] [smallint] NOT NULL,
[LanguageID] [smallint] NOT NULL,
[UserTypeName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[UserTypeByLanguage] ADD CONSTRAINT [PK_UserTypeByLanguage] PRIMARY KEY CLUSTERED  ([UserTypeID], [LanguageID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[UserTypeByLanguage] ADD CONSTRAINT [FK_UserTypeByLanguage_Language] FOREIGN KEY ([LanguageID]) REFERENCES [dbo].[Language] ([LanguageId])
GO
ALTER TABLE [dbo].[UserTypeByLanguage] ADD CONSTRAINT [FK_UserTypeByLanguage_UserType] FOREIGN KEY ([UserTypeID]) REFERENCES [dbo].[UserType] ([UserTypeID])
GO
