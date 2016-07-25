CREATE TABLE [dbo].[ErrorMessage]
(
[ErrorMessageID] [int] NOT NULL,
[Code] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Message] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ErrorMessage] ADD CONSTRAINT [PK_ErrorMessage] PRIMARY KEY CLUSTERED  ([ErrorMessageID]) ON [PRIMARY]
GO
