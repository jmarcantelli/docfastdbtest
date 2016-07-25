CREATE TABLE [dbo].[PaymentProvider]
(
[PaymentProviderID] [smallint] NOT NULL,
[PaymentProviderName] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Description] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[HostedPageUrl] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[WebServiceSoapApiUrl] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PaymentProvider] ADD CONSTRAINT [PK_PaymentProvider] PRIMARY KEY CLUSTERED  ([PaymentProviderID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PaymentProvider] ADD CONSTRAINT [uc_PaymentProviderName] UNIQUE NONCLUSTERED  ([PaymentProviderName]) ON [PRIMARY]
GO
