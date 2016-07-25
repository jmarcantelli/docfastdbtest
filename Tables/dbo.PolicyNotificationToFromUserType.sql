CREATE TABLE [dbo].[PolicyNotificationToFromUserType]
(
[ProlicyNotificationToFromUserTypeID] [int] NOT NULL IDENTITY(1, 1),
[DeliveryTypeID] [smallint] NOT NULL,
[InitiatingUserTypeID] [smallint] NOT NULL,
[RecipientUserTypeID] [smallint] NOT NULL,
[PolicyStatusID] [smallint] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PolicyNotificationToFromUserType] ADD CONSTRAINT [PK_PolicyNotificationToFromUserType] PRIMARY KEY CLUSTERED  ([ProlicyNotificationToFromUserTypeID]) ON [PRIMARY]
GO
