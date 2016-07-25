CREATE TABLE [dbo].[PaymentMode]
(
[PaymentModeID] [smallint] NOT NULL,
[PaymentMode] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PaymentMode] ADD CONSTRAINT [PK_PaymentMode] PRIMARY KEY CLUSTERED  ([PaymentModeID]) ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'A list of the Payment Modes in the system (Annual, Semi-Annual, Quarterly, Monthly).', 'SCHEMA', N'dbo', 'TABLE', N'PaymentMode', NULL, NULL
GO
