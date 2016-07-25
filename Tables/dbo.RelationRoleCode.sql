CREATE TABLE [dbo].[RelationRoleCode]
(
[RelationRoleCodeId] [int] NOT NULL,
[CodeValue] [int] NOT NULL,
[CodeName] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DisplayName] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Description] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RelationRoleCode] ADD CONSTRAINT [PK_RelationRoleCode] PRIMARY KEY CLUSTERED  ([RelationRoleCodeId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RelationRoleCode] ADD CONSTRAINT [uc_RelationRoleCodeName] UNIQUE NONCLUSTERED  ([CodeName]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RelationRoleCode] ADD CONSTRAINT [uc_RelationRoleCodeValue] UNIQUE NONCLUSTERED  ([CodeValue]) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [idx_Unique_RoleCodeDisplayName] ON [dbo].[RelationRoleCode] ([DisplayName]) ON [PRIMARY]
GO
