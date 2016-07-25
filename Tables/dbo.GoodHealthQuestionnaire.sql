CREATE TABLE [dbo].[GoodHealthQuestionnaire]
(
[GoodHealthQuestionnaireID] [int] NOT NULL IDENTITY(1, 1),
[SupplierID] [int] NOT NULL,
[QuestionnaireName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Description] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[IntroductionText] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UnderwriterReviewText] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ProviderFormNumber] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[AddlInfoFieldName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AddlInfoDateFieldName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ProviderFieldName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[GoodHealthQuestionnaire] ADD CONSTRAINT [PK_GoodHealthQuestionnaire] PRIMARY KEY CLUSTERED  ([GoodHealthQuestionnaireID]) ON [PRIMARY]
GO
