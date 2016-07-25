CREATE TABLE [dbo].[PolicyDeliveryType]
(
[PolicyDeliveryTypeID] [int] NOT NULL,
[DeliveryTypeCode] [nchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Description] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PolicyDeliveryType] ADD CONSTRAINT [PK_PolicyDeliveryType] PRIMARY KEY CLUSTERED  ([PolicyDeliveryTypeID]) ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a list of the different flows a policy can take through the system (i.e. Distributor to Agent, Direct Writer, Direct to Consumer, etc.)', 'SCHEMA', N'dbo', 'TABLE', N'PolicyDeliveryType', NULL, NULL
GO
