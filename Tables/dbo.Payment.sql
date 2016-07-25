CREATE TABLE [dbo].[Payment]
(
[PaymentID] [bigint] NOT NULL IDENTITY(1, 1),
[PolicyID] [bigint] NOT NULL,
[ConsumerRecipientID] [bigint] NOT NULL,
[PaymentTypeID] [smallint] NOT NULL,
[CreateDate] [datetime] NOT NULL,
[PaymentModeID] [smallint] NOT NULL CONSTRAINT [DF_Payment_PaymentModeID] DEFAULT ((1)),
[DraftDay] [smallint] NULL,
[PaymentTermID] [smallint] NOT NULL CONSTRAINT [DF_Payment_PaymentTermID] DEFAULT ((1)),
[PaymentTranTypeID] [smallint] NOT NULL CONSTRAINT [DF_Payment_PaymentTranTypeID] DEFAULT ((1)),
[TransactionResult] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PaymentProviderID] [smallint] NULL CONSTRAINT [DF__Payment__Payment__4A4ED1F3] DEFAULT ((1)),
[PaymentUpdateTranTypeID] [smallint] NULL,
[TransactionUpdateResult] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ExistingAccount] [bit] NOT NULL CONSTRAINT [DF_Payment_ExistingAccount] DEFAULT ((0))
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[Payment] ADD CONSTRAINT [PK_Payment] PRIMARY KEY CLUSTERED  ([PaymentID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Payment] ADD CONSTRAINT [uc_PaymentConsumerRecipientPaymentTerm] UNIQUE NONCLUSTERED  ([ConsumerRecipientID], [PaymentTermID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Payment] ADD CONSTRAINT [uc_PaymentPolicyPaymentTerm] UNIQUE NONCLUSTERED  ([PolicyID], [PaymentTermID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Payment] ADD CONSTRAINT [FK_Payment_ConsumerRecipient] FOREIGN KEY ([ConsumerRecipientID]) REFERENCES [dbo].[ConsumerRecipient] ([ConsumerRecipientID])
GO
ALTER TABLE [dbo].[Payment] ADD CONSTRAINT [FK_Payment_PaymentMode] FOREIGN KEY ([PaymentModeID]) REFERENCES [dbo].[PaymentMode] ([PaymentModeID])
GO
ALTER TABLE [dbo].[Payment] ADD CONSTRAINT [FK_Payment_PaymentProvider] FOREIGN KEY ([PaymentProviderID]) REFERENCES [dbo].[PaymentProvider] ([PaymentProviderID])
GO
ALTER TABLE [dbo].[Payment] ADD CONSTRAINT [FK_Payment_PaymentTerm] FOREIGN KEY ([PaymentTermID]) REFERENCES [dbo].[PaymentTerm] ([PaymentTermID])
GO
ALTER TABLE [dbo].[Payment] ADD CONSTRAINT [FK_Payment_PaymentTranType] FOREIGN KEY ([PaymentTranTypeID]) REFERENCES [dbo].[PaymentTranType] ([PaymentTranTypeID])
GO
ALTER TABLE [dbo].[Payment] ADD CONSTRAINT [FK_Payment_PaymentType] FOREIGN KEY ([PaymentTypeID]) REFERENCES [dbo].[PaymentType] ([PaymentTypeID])
GO
ALTER TABLE [dbo].[Payment] ADD CONSTRAINT [FK_Payment_Policy] FOREIGN KEY ([PolicyID]) REFERENCES [dbo].[Policy] ([PolicyID])
GO
