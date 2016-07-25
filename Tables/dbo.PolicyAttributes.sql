CREATE TABLE [dbo].[PolicyAttributes]
(
[PolicyID] [bigint] NOT NULL,
[AttributeKey] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[AttributeLabel] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AttributeValue] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Display] [bit] NULL,
[DisplayOrder] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PolicyAttributes] ADD CONSTRAINT [PK_PolicyAttributes] PRIMARY KEY CLUSTERED  ([PolicyID], [AttributeKey]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PolicyAttributes] ADD CONSTRAINT [FK_PolicyAttributes_Policy] FOREIGN KEY ([PolicyID]) REFERENCES [dbo].[Policy] ([PolicyID])
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table lists all the extended properties for a Policy not contained in the Policy table.  This will primarily be used to store the Policy details a Supplier may send us to display on the Policy Details screen.', 'SCHEMA', N'dbo', 'TABLE', N'PolicyAttributes', NULL, NULL
GO
