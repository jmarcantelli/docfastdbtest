CREATE TABLE [dbo].[CodeValueByLanguage]
(
[CodeValueID] [int] NOT NULL,
[LanguageID] [int] NOT NULL,
[DisplayName] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CodeValueByLanguage] ADD CONSTRAINT [PK_CodeValueByLanguage] PRIMARY KEY CLUSTERED  ([CodeValueID], [LanguageID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CodeValueByLanguage] ADD CONSTRAINT [FK_CodeValueByLanguage_CodeValue] FOREIGN KEY ([CodeValueID]) REFERENCES [dbo].[CodeValue] ([CodeValueID])
GO
EXEC sp_addextendedproperty N'MS_Description', N'A list of the type of code values by language in the system.', 'SCHEMA', N'dbo', 'TABLE', N'CodeValueByLanguage', NULL, NULL
GO
