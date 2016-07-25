CREATE TABLE [dbo].[MobileDeviceTokens]
(
[DeviceToken] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DeviceModel] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DeviceManufacturer] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MobileDeviceTokens] ADD CONSTRAINT [PK_MobileDeviceTokens] PRIMARY KEY CLUSTERED  ([DeviceToken]) ON [PRIMARY]
GO
