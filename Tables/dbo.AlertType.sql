CREATE TABLE [dbo].[AlertType]
(
[AlertTypeID] [int] NOT NULL,
[AlertType] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DisplayName] [nvarchar] (400) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AlertType] ADD CONSTRAINT [PK_AlertType] PRIMARY KEY CLUSTERED  ([AlertTypeID]) ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a list of Alerts that can be triggered by the system.', 'SCHEMA', N'dbo', 'TABLE', N'AlertType', NULL, NULL
GO
