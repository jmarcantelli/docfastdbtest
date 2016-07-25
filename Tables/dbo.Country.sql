CREATE TABLE [dbo].[Country]
(
[CountryID] [smallint] NOT NULL,
[CountryName] [nvarchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CountryCD] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CreatedBy] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ModifiedBy] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CreateDate] [datetime] NULL CONSTRAINT [DF__Country__CreateD__7D439ABD] DEFAULT (getdate()),
[ModifiedDate] [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Country] ADD CONSTRAINT [Country_PK] PRIMARY KEY NONCLUSTERED  ([CountryID]) ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'Lookup table of countries for locations. Maintained in (AdminPipe?). Maintained by iPipeline Administrators.', 'SCHEMA', N'dbo', 'TABLE', N'Country', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'CountryCD is abbreviation of Country', 'SCHEMA', N'dbo', 'TABLE', N'Country', 'COLUMN', N'CountryCD'
GO
EXEC sp_addextendedproperty N'MS_Description', N'CountryID identifies Country', 'SCHEMA', N'dbo', 'TABLE', N'Country', 'COLUMN', N'CountryID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Name of Country', 'SCHEMA', N'dbo', 'TABLE', N'Country', 'COLUMN', N'CountryName'
GO
