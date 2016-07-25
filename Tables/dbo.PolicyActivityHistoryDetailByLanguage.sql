CREATE TABLE [dbo].[PolicyActivityHistoryDetailByLanguage]
(
[PolicyActivityHistoryDetailID] [bigint] NOT NULL,
[LanguageID] [smallint] NOT NULL,
[Activity] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[PolicyActivityHistoryDetailByLanguage] ADD CONSTRAINT [PK_PolicyActivityHistoryDetailByLanguage] PRIMARY KEY CLUSTERED  ([PolicyActivityHistoryDetailID], [LanguageID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PolicyActivityHistoryDetailByLanguage] ADD CONSTRAINT [FK_PolicyActivityHistoryDetailByLanguage_Language] FOREIGN KEY ([LanguageID]) REFERENCES [dbo].[Language] ([LanguageId])
GO
ALTER TABLE [dbo].[PolicyActivityHistoryDetailByLanguage] ADD CONSTRAINT [FK_PolicyActivityHistoryDetailByLanguage_PolicyActivityHistoryDetail] FOREIGN KEY ([PolicyActivityHistoryDetailID]) REFERENCES [dbo].[PolicyActivityHistoryDetail] ([PolicyActivityHistoryDetailID])
GO
