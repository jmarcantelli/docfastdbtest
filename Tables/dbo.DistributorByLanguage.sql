CREATE TABLE [dbo].[DistributorByLanguage]
(
[DistributorID] [int] NOT NULL,
[LanguageID] [smallint] NOT NULL,
[Name] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DistributorByLanguage] ADD CONSTRAINT [PK_DistributorByLanguage] PRIMARY KEY CLUSTERED  ([DistributorID], [LanguageID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DistributorByLanguage] ADD CONSTRAINT [FK_DistributorByLanguage_Distributor] FOREIGN KEY ([DistributorID]) REFERENCES [dbo].[Distributor] ([DistributorID])
GO
ALTER TABLE [dbo].[DistributorByLanguage] ADD CONSTRAINT [FK_DistributorByLanguage_DistributorByLanguage] FOREIGN KEY ([DistributorID], [LanguageID]) REFERENCES [dbo].[DistributorByLanguage] ([DistributorID], [LanguageID])
GO
ALTER TABLE [dbo].[DistributorByLanguage] ADD CONSTRAINT [FK_DistributorByLanguage_Language] FOREIGN KEY ([LanguageID]) REFERENCES [dbo].[Language] ([LanguageId])
GO
