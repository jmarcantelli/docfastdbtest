CREATE TABLE [dbo].[AlertCriteriaByLanguage]
(
[AlertCriteriaID] [int] NOT NULL,
[LanguageID] [smallint] NOT NULL,
[AlertText] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[AlertCriteriaByLanguage] ADD CONSTRAINT [PK_AlertCriteriaByLanguage] PRIMARY KEY CLUSTERED  ([AlertCriteriaID], [LanguageID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AlertCriteriaByLanguage] ADD CONSTRAINT [FK_AlertCriteriaByLanguage_AlertCriteria] FOREIGN KEY ([AlertCriteriaID]) REFERENCES [dbo].[AlertCriteria] ([AlertCriteriaID])
GO
ALTER TABLE [dbo].[AlertCriteriaByLanguage] ADD CONSTRAINT [FK_AlertCriteriaByLanguage_Language] FOREIGN KEY ([LanguageID]) REFERENCES [dbo].[Language] ([LanguageId])
GO
