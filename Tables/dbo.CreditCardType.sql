CREATE TABLE [dbo].[CreditCardType]
(
[CreditCardTypeID] [smallint] NOT NULL,
[Name] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Description] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ImageName] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DisplayOrder] [smallint] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CreditCardType] ADD CONSTRAINT [PK_CreditCardType] PRIMARY KEY CLUSTERED  ([CreditCardTypeID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CreditCardType] ADD CONSTRAINT [uc_CreditCardTypeName] UNIQUE NONCLUSTERED  ([Name]) ON [PRIMARY]
GO
