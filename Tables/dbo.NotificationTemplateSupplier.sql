CREATE TABLE [dbo].[NotificationTemplateSupplier]
(
[NotificationTemplateSupplierID] [int] NOT NULL,
[NotificationTemplateDefaultID] [int] NOT NULL,
[SupplierID] [int] NOT NULL,
[PackageTypeID] [smallint] NULL,
[TemplateXSL] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[TemplateReferenceId] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[NotificationTemplateSupplier] ADD CONSTRAINT [PK_NotificationTemplateSupplier] PRIMARY KEY CLUSTERED  ([NotificationTemplateSupplierID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[NotificationTemplateSupplier] ADD CONSTRAINT [UQ_NotificationTemplateSupplierProductType] UNIQUE NONCLUSTERED  ([NotificationTemplateDefaultID], [SupplierID], [PackageTypeID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[NotificationTemplateSupplier] ADD CONSTRAINT [uc_NotificationTemplateSupplier_TemplateReferenceId] UNIQUE NONCLUSTERED  ([TemplateReferenceId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[NotificationTemplateSupplier] ADD CONSTRAINT [FK_NotificationTemplateSupplier_NotificationTemplateDefault] FOREIGN KEY ([NotificationTemplateDefaultID]) REFERENCES [dbo].[NotificationTemplateDefault] ([NotificationTemplateID])
GO
ALTER TABLE [dbo].[NotificationTemplateSupplier] ADD CONSTRAINT [FK_NotificationTemplateSupplier_PackageType] FOREIGN KEY ([PackageTypeID]) REFERENCES [dbo].[PackageType] ([PackageTypeID])
GO
