CREATE TABLE [dbo].[Language]
(
[LanguageId] [smallint] NOT NULL,
[Code] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Name] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[AcordCodeValue] [smallint] NULL,
[AcordCodeName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Language] ADD CONSTRAINT [PK_Language] PRIMARY KEY CLUSTERED  ([LanguageId]) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [idx_Unique_AcordCodeName] ON [dbo].[Language] ([AcordCodeName]) WHERE ([AcordCodeName] IS NOT NULL) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [idx_Unique_AcordCodeValue] ON [dbo].[Language] ([AcordCodeValue]) WHERE ([AcordCodeValue] IS NOT NULL) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Language] ADD CONSTRAINT [UQ_Language] UNIQUE NONCLUSTERED  ([Code]) ON [PRIMARY]
GO
