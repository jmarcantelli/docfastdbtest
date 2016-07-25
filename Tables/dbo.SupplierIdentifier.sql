CREATE TABLE [dbo].[SupplierIdentifier]
(
[SupplierID] [int] NOT NULL,
[CarrierCode] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SupplierName] [nvarchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CreatedBy] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CreateDate] [datetime] NOT NULL,
[Description] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Active] [bit] NOT NULL CONSTRAINT [DF__SupplierI__Activ__74450BBF] DEFAULT ((1))
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SupplierIdentifier] ADD CONSTRAINT [PK_SupplierIdentifier_1] PRIMARY KEY CLUSTERED  ([SupplierID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SupplierIdentifier] ADD CONSTRAINT [uq_SupplierIdentifier_CarrierCode] UNIQUE NONCLUSTERED  ([CarrierCode]) ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table defines the CarrierCode that will be used in the ACORD messages to identify the Suppliers', 'SCHEMA', N'dbo', 'TABLE', N'SupplierIdentifier', NULL, NULL
GO
