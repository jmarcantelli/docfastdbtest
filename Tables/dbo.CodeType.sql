CREATE TABLE [dbo].[CodeType]
(
[CodeTypeID] [int] NOT NULL,
[Name] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Description] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AcordCodeName] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CodeType] ADD CONSTRAINT [PK_CodeType] PRIMARY KEY CLUSTERED  ([CodeTypeID]) ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'A list of the type of codes in the system.', 'SCHEMA', N'dbo', 'TABLE', N'CodeType', NULL, NULL
GO
