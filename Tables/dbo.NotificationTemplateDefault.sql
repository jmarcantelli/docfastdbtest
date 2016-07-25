CREATE TABLE [dbo].[NotificationTemplateDefault]
(
[NotificationTemplateID] [int] NOT NULL IDENTITY(1, 1),
[OriginalTemplateName] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[TemplateXSL] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[TemplateReferenceId] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[NotificationTemplateDefault] ADD CONSTRAINT [PK_NotificationTemplateDefault] PRIMARY KEY CLUSTERED  ([NotificationTemplateID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[NotificationTemplateDefault] ADD CONSTRAINT [uc_NotificationTemplateDefault_TemplateReferenceId] UNIQUE NONCLUSTERED  ([TemplateReferenceId]) ON [PRIMARY]
GO
GRANT ALTER ON  [dbo].[NotificationTemplateDefault] TO [AppUser_PolicyEX]
GO
GRANT CONTROL ON  [dbo].[NotificationTemplateDefault] TO [AppUser_PolicyEX]
GO
GRANT TAKE OWNERSHIP ON  [dbo].[NotificationTemplateDefault] TO [AppUser_PolicyEX]
GO
GRANT VIEW DEFINITION ON  [dbo].[NotificationTemplateDefault] TO [AppUser_PolicyEX]
GO
GRANT REFERENCES ON  [dbo].[NotificationTemplateDefault] TO [AppUser_PolicyEX]
GO
GRANT SELECT ON  [dbo].[NotificationTemplateDefault] TO [AppUser_PolicyEX]
GO
GRANT INSERT ON  [dbo].[NotificationTemplateDefault] TO [AppUser_PolicyEX]
GO
GRANT DELETE ON  [dbo].[NotificationTemplateDefault] TO [AppUser_PolicyEX]
GO
GRANT UPDATE ON  [dbo].[NotificationTemplateDefault] TO [AppUser_PolicyEX]
GO
