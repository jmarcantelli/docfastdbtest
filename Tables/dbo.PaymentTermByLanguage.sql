CREATE TABLE [dbo].[PaymentTermByLanguage]
(
[PaymentTermID] [smallint] NOT NULL,
[LanguageID] [smallint] NOT NULL,
[PaymentTermName] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PaymentTermByLanguage] ADD CONSTRAINT [PK_PaymentTermByLanguage] PRIMARY KEY CLUSTERED  ([PaymentTermID], [LanguageID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PaymentTermByLanguage] ADD CONSTRAINT [FK_PaymentTermByLanguage_Language] FOREIGN KEY ([LanguageID]) REFERENCES [dbo].[Language] ([LanguageId])
GO
ALTER TABLE [dbo].[PaymentTermByLanguage] ADD CONSTRAINT [FK_PaymentTermByLanguage_PaymentTerm] FOREIGN KEY ([PaymentTermID]) REFERENCES [dbo].[PaymentTerm] ([PaymentTermID])
GO
