CREATE TABLE [dbo].[ConsumerPortalLoginMsgSupplier]
(
[SupplierID] [int] NOT NULL,
[LoginMessage] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ConsumerPortalLoginMsgID] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ConsumerPortalLoginMsgSupplier] ADD CONSTRAINT [PK_ConsumerPortalLoginMsgSupplier] PRIMARY KEY CLUSTERED  ([SupplierID], [ConsumerPortalLoginMsgID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ConsumerPortalLoginMsgSupplier] ADD CONSTRAINT [FK_ConsumerPortalLoginMsgSupplier_ConsumerPortalLoginMsg] FOREIGN KEY ([ConsumerPortalLoginMsgID]) REFERENCES [dbo].[ConsumerPortalLoginMsg] ([ConsumerPortalLoginMsgID])
GO
