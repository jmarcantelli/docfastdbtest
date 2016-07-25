CREATE TABLE [dbo].[State]
(
[StateID] [smallint] NOT NULL,
[CountryID] [smallint] NOT NULL,
[StateCD] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[StateName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CreatedBy] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ModifiedBy] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CreateDate] [datetime] NULL CONSTRAINT [DF__State__Create__17036CC0] DEFAULT (getdate()),
[ModifiedDate] [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[State] ADD CONSTRAINT [PK_State] PRIMARY KEY CLUSTERED  ([StateID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[State] ADD CONSTRAINT [Country_State_FK1] FOREIGN KEY ([CountryID]) REFERENCES [dbo].[Country] ([CountryID])
GO
EXEC sp_addextendedproperty N'MS_Description', N'Contains all states.', 'SCHEMA', N'dbo', 'TABLE', N'State', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'CountryID of Country for this State', 'SCHEMA', N'dbo', 'TABLE', N'State', 'COLUMN', N'CountryID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'StateCD is the actual code for the State (PA, DE etc.)', 'SCHEMA', N'dbo', 'TABLE', N'State', 'COLUMN', N'StateCD'
GO
EXEC sp_addextendedproperty N'MS_Description', N'StateName is the State full Name', 'SCHEMA', N'dbo', 'TABLE', N'State', 'COLUMN', N'StateName'
GO
