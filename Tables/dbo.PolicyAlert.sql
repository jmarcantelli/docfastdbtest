CREATE TABLE [dbo].[PolicyAlert]
(
[PolicyAlertID] [bigint] NOT NULL IDENTITY(1, 1),
[PolicyID] [bigint] NULL,
[UserID] [int] NULL,
[AlertTypeID] [int] NULL,
[AlertText] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AlertRating] [tinyint] NULL,
[MessageID] [bigint] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[PolicyAlert] ADD CONSTRAINT [PK_PolicyAlert] PRIMARY KEY CLUSTERED  ([PolicyAlertID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PolicyAlert] ADD CONSTRAINT [FK_PolicyAlert_AlertType] FOREIGN KEY ([AlertTypeID]) REFERENCES [dbo].[AlertType] ([AlertTypeID])
GO
ALTER TABLE [dbo].[PolicyAlert] ADD CONSTRAINT [FK_PolicyAlert_Policy] FOREIGN KEY ([PolicyID]) REFERENCES [dbo].[Policy] ([PolicyID])
GO
ALTER TABLE [dbo].[PolicyAlert] ADD CONSTRAINT [FK_PolicyAlert_User] FOREIGN KEY ([UserID]) REFERENCES [dbo].[User] ([UserID])
GO
