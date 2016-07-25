CREATE TABLE [dbo].[PaymentTerm]
(
[PaymentTermID] [smallint] NOT NULL,
[PaymentTermName] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PaymentTerm] ADD CONSTRAINT [PK_PaymentTerm] PRIMARY KEY CLUSTERED  ([PaymentTermID]) ON [PRIMARY]
GO
