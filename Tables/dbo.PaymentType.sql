CREATE TABLE [dbo].[PaymentType]
(
[PaymentTypeID] [smallint] NOT NULL,
[PaymentTypeName] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Description] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Active] [bit] NOT NULL,
[DisplayOrder] [smallint] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PaymentType] ADD CONSTRAINT [PK_PaymentType] PRIMARY KEY CLUSTERED  ([PaymentTypeID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_PaymentType] ON [dbo].[PaymentType] ([PaymentTypeID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PaymentType] ADD CONSTRAINT [uc_PaymentTypeName] UNIQUE NONCLUSTERED  ([PaymentTypeName]) ON [PRIMARY]
GO
