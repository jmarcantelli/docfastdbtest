CREATE TABLE [dbo].[PaymentTranType]
(
[PaymentTranTypeID] [smallint] NOT NULL,
[TranTypeName] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Description] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PaymentTranType] ADD CONSTRAINT [PK_PaymentTranType] PRIMARY KEY CLUSTERED  ([PaymentTranTypeID]) ON [PRIMARY]
GO
