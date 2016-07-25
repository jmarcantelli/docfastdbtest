CREATE TABLE [dbo].[DocumentFieldMapping]
(
[DocumentFieldMappingId] [int] NOT NULL,
[SupplierID] [int] NOT NULL,
[FieldName] [nvarchar] (400) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Description] [varchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[FieldMatchType] [int] NOT NULL,
[DocRoutingDestType] [int] NOT NULL,
[FieldType] [int] NOT NULL,
[ValidationPattern] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ValidationMessage] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ConditionalRoutingDestType] [int] NULL,
[FallBackRoutingDestType] [int] NULL,
[DateToSigLink] [int] NULL,
[Required] [bit] NOT NULL,
[Active] [bit] NOT NULL CONSTRAINT [DF_DocumentFieldMapping_Active] DEFAULT ((1)),
[CreatedBy] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CreateDate] [datetime] NOT NULL,
[ModifiedBy] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ModifiedDate] [datetime] NOT NULL,
[FieldValuePropertyName] [nvarchar] (400) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DocumentFieldMapping] ADD CONSTRAINT [PK_DocumentFieldMapping] PRIMARY KEY CLUSTERED  ([DocumentFieldMappingId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DocumentFieldMapping] ADD CONSTRAINT [uc_SupplierIDFieldName] UNIQUE NONCLUSTERED  ([SupplierID], [FieldName]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DocumentFieldMapping] ADD CONSTRAINT [FK_DocumentFieldMapping_SupplierIdentifier] FOREIGN KEY ([SupplierID]) REFERENCES [dbo].[SupplierIdentifier] ([SupplierID])
GO
