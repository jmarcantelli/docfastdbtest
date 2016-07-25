CREATE TABLE [dbo].[PolicyActionSignerStatus]
(
[PolicyDeliveryTypeID] [int] NOT NULL,
[UserTypeID] [smallint] NOT NULL,
[ActionID] [smallint] NOT NULL,
[SignerUserTypeID] [smallint] NOT NULL,
[PrevSignerStatusID] [int] NULL,
[NewSignerStatusID] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PolicyActionSignerStatus] ADD CONSTRAINT [FK_PolicyActionSignerStatus_Action] FOREIGN KEY ([ActionID]) REFERENCES [dbo].[Action] ([ActionID])
GO
ALTER TABLE [dbo].[PolicyActionSignerStatus] ADD CONSTRAINT [FK_PolicyActionSignerStatus_NewSignerStatus] FOREIGN KEY ([NewSignerStatusID]) REFERENCES [dbo].[SignerStatus] ([SignerStatusID])
GO
ALTER TABLE [dbo].[PolicyActionSignerStatus] ADD CONSTRAINT [FK_PolicyActionSignerStatus_PolicyActionSignerStatus] FOREIGN KEY ([PolicyDeliveryTypeID]) REFERENCES [dbo].[PolicyDeliveryType] ([PolicyDeliveryTypeID])
GO
ALTER TABLE [dbo].[PolicyActionSignerStatus] ADD CONSTRAINT [FK_PolicyActionSignerStatus_PrevSignerStatus] FOREIGN KEY ([PrevSignerStatusID]) REFERENCES [dbo].[SignerStatus] ([SignerStatusID])
GO
ALTER TABLE [dbo].[PolicyActionSignerStatus] ADD CONSTRAINT [FK_PolicyActionSignerStatus_SignerUserType] FOREIGN KEY ([SignerUserTypeID]) REFERENCES [dbo].[UserType] ([UserTypeID])
GO
ALTER TABLE [dbo].[PolicyActionSignerStatus] ADD CONSTRAINT [FK_PolicyActionSignerStatus_UserType] FOREIGN KEY ([UserTypeID]) REFERENCES [dbo].[UserType] ([UserTypeID])
GO
