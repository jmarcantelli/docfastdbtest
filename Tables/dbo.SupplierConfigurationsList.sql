CREATE TABLE [dbo].[SupplierConfigurationsList]
(
[ConfigurationKey] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Description] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ValueRequired] [bit] NOT NULL,
[DefaultValue] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PossibleValues] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[AffectedParty] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Notes] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[SupplierConfigurationsList] ADD CONSTRAINT [PK_SupplierConfigurationsList_1] PRIMARY KEY CLUSTERED  ([ConfigurationKey]) ON [PRIMARY]
GO
