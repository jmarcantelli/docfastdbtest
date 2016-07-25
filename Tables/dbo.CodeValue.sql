CREATE TABLE [dbo].[CodeValue]
(
[CodeValueID] [int] NOT NULL,
[CodeTypeID] [int] NOT NULL,
[DisplayOrder] [smallint] NOT NULL,
[DisplayName] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Description] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AcordCodeValue] [int] NULL,
[AcordCodeName] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CodeValue] ADD CONSTRAINT [PK_CodeValue] PRIMARY KEY CLUSTERED  ([CodeValueID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CodeValue] ADD CONSTRAINT [FK_CodeValue_CodeType] FOREIGN KEY ([CodeTypeID]) REFERENCES [dbo].[CodeType] ([CodeTypeID])
GO
EXEC sp_addextendedproperty N'MS_Description', N'A list of the type of code values in the system.', 'SCHEMA', N'dbo', 'TABLE', N'CodeValue', NULL, NULL
GO
