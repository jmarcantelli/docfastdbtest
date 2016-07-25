CREATE TABLE [dbo].[PaymentProviderDetailType]
(
[PaymentProviderDetailTypeID] [smallint] NOT NULL,
[DetailTypeName] [nvarchar] (400) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Description] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PaymentProviderDetailType] ADD CONSTRAINT [PK_PaymentProviderTransType] PRIMARY KEY CLUSTERED  ([PaymentProviderDetailTypeID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PaymentProviderDetailType] ADD CONSTRAINT [uc_PaymentProviderDetailTypeName] UNIQUE NONCLUSTERED  ([DetailTypeName]) ON [PRIMARY]
GO
