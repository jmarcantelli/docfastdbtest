CREATE TABLE [dbo].[PolicyDeliveryTypeByLanguage]
(
[PolicyDeliveryTypeID] [int] NOT NULL,
[LanguageID] [smallint] NOT NULL,
[Description] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PolicyDeliveryTypeByLanguage] ADD CONSTRAINT [PK_PolicyDeliveryTypeByLanguage] PRIMARY KEY CLUSTERED  ([PolicyDeliveryTypeID], [LanguageID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PolicyDeliveryTypeByLanguage] ADD CONSTRAINT [FK_PolicyDeliveryTypeByLanguage_Language] FOREIGN KEY ([LanguageID]) REFERENCES [dbo].[Language] ([LanguageId])
GO
ALTER TABLE [dbo].[PolicyDeliveryTypeByLanguage] ADD CONSTRAINT [FK_PolicyDeliveryTypeByLanguage_PolicyDeliveryType] FOREIGN KEY ([PolicyDeliveryTypeID]) REFERENCES [dbo].[PolicyDeliveryType] ([PolicyDeliveryTypeID])
GO
ALTER TABLE [dbo].[PolicyDeliveryTypeByLanguage] ADD CONSTRAINT [FK_PolicyDeliveryTypeByLanguage_PolicyDeliveryTypeByLanguage] FOREIGN KEY ([PolicyDeliveryTypeID], [LanguageID]) REFERENCES [dbo].[PolicyDeliveryTypeByLanguage] ([PolicyDeliveryTypeID], [LanguageID])
GO
