CREATE TABLE [dbo].[SupplierCarrier]
(
[SupplierCarrierID] [int] NOT NULL IDENTITY(1, 1),
[SupplierID] [int] NOT NULL,
[CarrierCode] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CarrierName] [nvarchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Description] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CreatedBy] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CreateDate] [datetime] NOT NULL,
[Active] [bit] NOT NULL CONSTRAINT [DF__SupplierC__Activ__32423E38] DEFAULT ((1))
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SupplierCarrier] ADD CONSTRAINT [PK_SupplierCarrier_1] PRIMARY KEY CLUSTERED  ([SupplierCarrierID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SupplierCarrier] ADD CONSTRAINT [uq_SupplierCarrier_CarrierCode] UNIQUE NONCLUSTERED  ([CarrierCode]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SupplierCarrier] ADD CONSTRAINT [FK_SupplierCarrier_SupplierIdentifier] FOREIGN KEY ([SupplierID]) REFERENCES [dbo].[SupplierIdentifier] ([SupplierID])
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table defines the CarrierCode that will be used in the ACORD messages to identify the Carrier', 'SCHEMA', N'dbo', 'TABLE', N'SupplierCarrier', NULL, NULL
GO
