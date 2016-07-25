CREATE TABLE [dbo].[FaceAmountOption]
(
[FaceAmountOptionID] [bigint] NOT NULL IDENTITY(1, 1),
[PolicyID] [bigint] NOT NULL,
[Sequence] [smallint] NOT NULL,
[Description] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[FaceAmount] [money] NOT NULL,
[ExchangeAmount1035] [money] NULL,
[ExchangeAmountNon1035] [money] NULL,
[PremiumCreditAmount] [money] NULL,
[Active] [bit] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[FaceAmountOption] ADD CONSTRAINT [PK_FaceAmountOption] PRIMARY KEY CLUSTERED  ([FaceAmountOptionID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[FaceAmountOption] ADD CONSTRAINT [FK_FaceAmountOption_Policy] FOREIGN KEY ([PolicyID]) REFERENCES [dbo].[Policy] ([PolicyID]) ON DELETE CASCADE
GO
