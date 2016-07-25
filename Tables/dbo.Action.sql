CREATE TABLE [dbo].[Action]
(
[ActionID] [smallint] NOT NULL,
[Action] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ActionGroupID] [smallint] NOT NULL CONSTRAINT [DF_Action_ActionGroupID] DEFAULT ((1)),
[SortOrder] [smallint] NOT NULL CONSTRAINT [DF_Action_SortOrder] DEFAULT ((1))
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Action] ADD CONSTRAINT [PK_Action] PRIMARY KEY CLUSTERED  ([ActionID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Action] ADD CONSTRAINT [FK_Action_ActionGroup] FOREIGN KEY ([ActionGroupID]) REFERENCES [dbo].[ActionGroup] ([ActionGroupID])
GO
