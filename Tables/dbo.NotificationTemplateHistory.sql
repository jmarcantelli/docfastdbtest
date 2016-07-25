CREATE TABLE [dbo].[NotificationTemplateHistory]
(
[NotificationTemplateHistoryID] [bigint] NOT NULL IDENTITY(1, 1),
[NotificationTemplateDefaultID] [int] NOT NULL,
[SupplierID] [int] NULL,
[TemplateXSL] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CreateDate] [datetime] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[NotificationTemplateHistory] ADD CONSTRAINT [PK_NotificationTemplateHistory] PRIMARY KEY CLUSTERED  ([NotificationTemplateHistoryID]) ON [PRIMARY]
GO
