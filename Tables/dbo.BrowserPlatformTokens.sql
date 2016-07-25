CREATE TABLE [dbo].[BrowserPlatformTokens]
(
[PlatformToken] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Description] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BrowserPlatformTokens] ADD CONSTRAINT [PK_BrowserPlatformTokens] PRIMARY KEY CLUSTERED  ([PlatformToken]) ON [PRIMARY]
GO
