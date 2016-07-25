CREATE TABLE [dbo].[PolicyRoleByLanguage]
(
[PolicyRoleID] [smallint] NOT NULL,
[LanguageID] [smallint] NOT NULL,
[PolicyRoleName] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PolicyRoleByLanguage] ADD CONSTRAINT [PK_PolicyRoleByLanguage] PRIMARY KEY CLUSTERED  ([PolicyRoleID], [LanguageID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PolicyRoleByLanguage] ADD CONSTRAINT [FK_PolicyRoleByLanguage_Language] FOREIGN KEY ([LanguageID]) REFERENCES [dbo].[Language] ([LanguageId])
GO
ALTER TABLE [dbo].[PolicyRoleByLanguage] ADD CONSTRAINT [FK_PolicyRoleByLanguage_PolicyRole] FOREIGN KEY ([PolicyRoleID]) REFERENCES [dbo].[PolicyRole] ([PolicyRoleID])
GO
