CREATE TABLE [dbo].[DocumentStatus]
(
[DocumentStatusID] [smallint] NOT NULL,
[DocumentStatusName] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DocumentStatusImage] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DocumentStatus] ADD CONSTRAINT [PK_DocumentStatus] PRIMARY KEY CLUSTERED  ([DocumentStatusID]) ON [PRIMARY]
GO
