CREATE TABLE [dbo].[Email]
(
[EmailID] [int] NOT NULL IDENTITY(1, 1),
[EmailAddress] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SecondAddress] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Email] ADD CONSTRAINT [PK_Email] PRIMARY KEY CLUSTERED  ([EmailID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Email] ADD CONSTRAINT [UQ_EmailAddress] UNIQUE NONCLUSTERED  ([EmailAddress]) ON [PRIMARY]
GO
