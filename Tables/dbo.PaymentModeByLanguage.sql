CREATE TABLE [dbo].[PaymentModeByLanguage]
(
[PaymentModeID] [smallint] NOT NULL,
[LanguageID] [smallint] NOT NULL,
[PaymentModeName] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PaymentModeByLanguage] ADD CONSTRAINT [PK_PaymentModeByLanguage] PRIMARY KEY CLUSTERED  ([PaymentModeID], [LanguageID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PaymentModeByLanguage] ADD CONSTRAINT [FK_PaymentModeByLanguage_Language] FOREIGN KEY ([LanguageID]) REFERENCES [dbo].[Language] ([LanguageId])
GO
ALTER TABLE [dbo].[PaymentModeByLanguage] ADD CONSTRAINT [FK_PaymentModeByLanguage_PaymentMode] FOREIGN KEY ([PaymentModeID]) REFERENCES [dbo].[PaymentMode] ([PaymentModeID])
GO
