CREATE TABLE [dbo].[SupplierUnknownUser]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[FirstName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[LastName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Email] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SupplierID] [int] NOT NULL,
[PolicyID] [bigint] NOT NULL,
[Role] [int] NOT NULL,
[SupplierUserID] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PolicyRoleID] [smallint] NOT NULL CONSTRAINT [DF_SupplierUnknownUser_IsCCUser] DEFAULT ((1))
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SupplierUnknownUser] ADD CONSTRAINT [PK_SupplierUnknownUser] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SupplierUnknownUser] ADD CONSTRAINT [FK_SupplierUnknownUser_Policy] FOREIGN KEY ([PolicyID]) REFERENCES [dbo].[Policy] ([PolicyID])
GO
