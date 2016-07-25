CREATE TABLE [dbo].[SignerStatus]
(
[SignerStatusID] [int] NOT NULL,
[SignerStatusName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SignerStatusImage] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SignerStatusCode] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SignerStatus] ADD CONSTRAINT [PK_SignerStatus] PRIMARY KEY CLUSTERED  ([SignerStatusID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SignerStatus] ADD CONSTRAINT [uqc_SignerStatusCode] UNIQUE NONCLUSTERED  ([SignerStatusCode]) ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table lists all the possible statuses of a signer in the system.', 'SCHEMA', N'dbo', 'TABLE', N'SignerStatus', NULL, NULL
GO
