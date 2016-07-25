CREATE TABLE [dbo].[ConsumerPortalLoginMsg]
(
[PolicyStatusID] [int] NOT NULL,
[LoginMessage] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ConsumerPortalLoginMsgID] [int] NOT NULL IDENTITY(1, 1)
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ConsumerPortalLoginMsg] ADD CONSTRAINT [PK_ConsumerPolicyStatusMessage] PRIMARY KEY CLUSTERED  ([ConsumerPortalLoginMsgID]) ON [PRIMARY]
GO
