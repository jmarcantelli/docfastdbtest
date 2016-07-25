CREATE TABLE [dbo].[Screen]
(
[ScreenID] [smallint] NOT NULL,
[WebSiteID] [smallint] NOT NULL,
[Name] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Description] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[WorkflowOrder] [smallint] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Screen] ADD CONSTRAINT [PK_Screen] PRIMARY KEY CLUSTERED  ([ScreenID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Screen] ADD CONSTRAINT [uc_ScreenWebSiteWorkflowOrder] UNIQUE NONCLUSTERED  ([WebSiteID], [WorkflowOrder]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Screen] ADD CONSTRAINT [FK_Screen_WebSite] FOREIGN KEY ([WebSiteID]) REFERENCES [dbo].[WebSite] ([WebSiteID])
GO
