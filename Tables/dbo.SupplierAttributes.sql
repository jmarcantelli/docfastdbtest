CREATE TABLE [dbo].[SupplierAttributes]
(
[SupplierID] [int] NOT NULL,
[AttributeKey] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[AttributeLabel] [nvarchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DefaultValue] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Display] [bit] NOT NULL CONSTRAINT [DF_SupplierAttributes_Display] DEFAULT ((1))
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SupplierAttributes] ADD CONSTRAINT [PK_SupplierAttributes] PRIMARY KEY CLUSTERED  ([SupplierID], [AttributeKey]) ON [PRIMARY]
GO
