CREATE TABLE [dbo].[PolicyActivityHistoryDetail]
(
[PolicyActivityHistoryDetailID] [bigint] NOT NULL IDENTITY(1, 1),
[PolicyActivityHistoryID] [bigint] NOT NULL,
[Activity] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[PolicyActivityHistoryDetail] ADD CONSTRAINT [PK_PolicyActivityHistoryDetail] PRIMARY KEY CLUSTERED  ([PolicyActivityHistoryDetailID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_PolicyActivityHistoryDetail_9] ON [dbo].[PolicyActivityHistoryDetail] ([PolicyActivityHistoryID]) INCLUDE ([Activity], [PolicyActivityHistoryDetailID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PolicyActivityHistoryDetail] ADD CONSTRAINT [FK_PolicyActivityHistoryDetail_PolicyActivityHistory] FOREIGN KEY ([PolicyActivityHistoryID]) REFERENCES [dbo].[PolicyActivityHistory] ([PolicyActivityHistoryID])
GO
