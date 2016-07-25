CREATE TABLE [dbo].[DataPipeServiceLog]
(
[DataPipeServiceLogID] [bigint] NOT NULL IDENTITY(1, 1),
[AppID] [int] NOT NULL,
[CustomerID] [int] NOT NULL,
[SupplierID] [int] NULL,
[PolNumber] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UserName] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MethodName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Status] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CreateDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DataPipeServiceLog] ADD CONSTRAINT [PK_DataPipeServiceLogID] PRIMARY KEY CLUSTERED  ([DataPipeServiceLogID]) ON [PRIMARY]
GO
