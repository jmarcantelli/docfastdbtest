CREATE TABLE [dbo].[PaymentTypeByLanguage]
(
[PaymentTypeID] [smallint] NOT NULL,
[LanguageID] [smallint] NOT NULL,
[PaymentTypeName] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PaymentTypeByLanguage] ADD CONSTRAINT [PK_PaymentTypeByLanguage] PRIMARY KEY CLUSTERED  ([PaymentTypeID], [LanguageID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PaymentTypeByLanguage] ADD CONSTRAINT [FK_PaymentTypeByLanguage_Language] FOREIGN KEY ([LanguageID]) REFERENCES [dbo].[Language] ([LanguageId])
GO
ALTER TABLE [dbo].[PaymentTypeByLanguage] ADD CONSTRAINT [FK_PaymentTypeByLanguage_PaymentType] FOREIGN KEY ([PaymentTypeID]) REFERENCES [dbo].[PaymentType] ([PaymentTypeID])
GO
