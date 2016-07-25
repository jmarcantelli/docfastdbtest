CREATE TABLE [dbo].[PremiumPaymentOption]
(
[PremiumPaymentOptionID] [bigint] NOT NULL IDENTITY(1, 1),
[FaceAmountOptionID] [bigint] NOT NULL,
[PremiumAmount] [money] NOT NULL,
[PaymentModeID] [smallint] NOT NULL,
[Active] [bit] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PremiumPaymentOption] ADD CONSTRAINT [PK_PremiumPaymentOption] PRIMARY KEY CLUSTERED  ([PremiumPaymentOptionID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PremiumPaymentOption] ADD CONSTRAINT [FK_PremiumPaymentOption_FaceAmountOption] FOREIGN KEY ([FaceAmountOptionID]) REFERENCES [dbo].[FaceAmountOption] ([FaceAmountOptionID]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PremiumPaymentOption] ADD CONSTRAINT [FK_PremiumPaymentOption_PaymentMode] FOREIGN KEY ([PaymentModeID]) REFERENCES [dbo].[PaymentMode] ([PaymentModeID]) ON DELETE CASCADE
GO
