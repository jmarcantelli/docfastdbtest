CREATE TABLE [dbo].[ActionGroup]
(
[ActionGroupID] [smallint] NOT NULL,
[ActionGroupName] [nvarchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ActionGroupImage] [nvarchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SortOrder] [smallint] NOT NULL CONSTRAINT [DF_ActionGroup_SortOrder] DEFAULT ((1))
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ActionGroup] ADD CONSTRAINT [PK_ActionGroup] PRIMARY KEY CLUSTERED  ([ActionGroupID]) ON [PRIMARY]
GO
