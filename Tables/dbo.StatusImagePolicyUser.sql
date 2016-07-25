CREATE TABLE [dbo].[StatusImagePolicyUser]
(
[StatusImagePolicyUserID] [int] NOT NULL IDENTITY(1, 1),
[PolicyDeliveryTypeID] [int] NOT NULL,
[UserTypeID] [smallint] NOT NULL,
[PolicyRoleID] [smallint] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[StatusImagePolicyUser] ADD CONSTRAINT [PK_StatusImagePolicyUser] PRIMARY KEY CLUSTERED  ([StatusImagePolicyUserID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[StatusImagePolicyUser] ADD CONSTRAINT [FK_StatusImagePolicyUser_PolicyDeliveryType] FOREIGN KEY ([PolicyDeliveryTypeID]) REFERENCES [dbo].[PolicyDeliveryType] ([PolicyDeliveryTypeID])
GO
ALTER TABLE [dbo].[StatusImagePolicyUser] ADD CONSTRAINT [FK_StatusImagePolicyUser_PolicyRole] FOREIGN KEY ([PolicyRoleID]) REFERENCES [dbo].[PolicyRole] ([PolicyRoleID])
GO
ALTER TABLE [dbo].[StatusImagePolicyUser] ADD CONSTRAINT [FK_StatusImagePolicyUser_UserType] FOREIGN KEY ([UserTypeID]) REFERENCES [dbo].[UserType] ([UserTypeID])
GO
