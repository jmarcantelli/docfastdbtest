CREATE TABLE [dbo].[WebSite]
(
[WebSiteID] [smallint] NOT NULL,
[Name] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Description] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[WebSite] ADD CONSTRAINT [PK_WebSite] PRIMARY KEY CLUSTERED  ([WebSiteID]) ON [PRIMARY]
GO
