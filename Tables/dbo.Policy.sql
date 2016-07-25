CREATE TABLE [dbo].[Policy]
(
[PolicyID] [bigint] NOT NULL IDENTITY(1, 1),
[SupplierID] [int] NOT NULL,
[PolNumber] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[XMLID] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[EffectiveDate] [datetime] NULL,
[DeliveryDate] [datetime] NULL,
[DocuSignID] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RawXML] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PolicyStatusID] [int] NULL,
[PolicyDeliveryTypeID] [int] NOT NULL,
[ConsumerName] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CreatedBy] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CreateDate] [datetime] NOT NULL,
[ModifiedBy] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ModifiedDate] [datetime] NOT NULL,
[PremiumAmount] [money] NULL,
[TransmissionStatus] [bit] NOT NULL CONSTRAINT [TransmissionStatus_default] DEFAULT ((0)),
[TransmissionOwnerUserID] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LanguageId] [smallint] NULL,
[EnforceSignerVisibility] [bit] NOT NULL CONSTRAINT [EnforceSignerVisibility_default] DEFAULT ((0)),
[EnableWetSign] [bit] NOT NULL CONSTRAINT [EnableWetSign_default] DEFAULT ((0)),
[ProductTypeID] [smallint] NULL,
[ProductCode] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CWAAmt] [money] NULL,
[PremiumBalanceDue] [money] NULL,
[ExpirationDate] [datetime] NULL,
[SupplierCarrierID] [int] NULL,
[BillingStopDate] [datetime] NULL,
[PackageTypeID] [smallint] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[Policy] ADD CONSTRAINT [PK_Policy] PRIMARY KEY CLUSTERED  ([PolicyID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Policy] ADD CONSTRAINT [Policy_UniquePolNumberBySupplierID] UNIQUE NONCLUSTERED  ([SupplierID], [PolNumber]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Policy] ADD CONSTRAINT [FK_Policy_Language] FOREIGN KEY ([LanguageId]) REFERENCES [dbo].[Language] ([LanguageId])
GO
ALTER TABLE [dbo].[Policy] ADD CONSTRAINT [FK_Policy_PackageType] FOREIGN KEY ([PackageTypeID]) REFERENCES [dbo].[PackageType] ([PackageTypeID])
GO
ALTER TABLE [dbo].[Policy] ADD CONSTRAINT [FK_Policy_PolicyDeliveryType] FOREIGN KEY ([PolicyDeliveryTypeID]) REFERENCES [dbo].[PolicyDeliveryType] ([PolicyDeliveryTypeID])
GO
ALTER TABLE [dbo].[Policy] ADD CONSTRAINT [FK_Policy_ProductType] FOREIGN KEY ([ProductTypeID]) REFERENCES [dbo].[ProductType] ([ProductTypeID])
GO
ALTER TABLE [dbo].[Policy] ADD CONSTRAINT [FK_Policy_Status] FOREIGN KEY ([PolicyStatusID]) REFERENCES [dbo].[PolicyStatus] ([PolicyStatusID])
GO
ALTER TABLE [dbo].[Policy] ADD CONSTRAINT [FK_Policy_SupplierCarrier] FOREIGN KEY ([SupplierCarrierID]) REFERENCES [dbo].[SupplierCarrier] ([SupplierCarrierID])
GO
ALTER TABLE [dbo].[Policy] ADD CONSTRAINT [FK_Policy_SupplierIdentifier] FOREIGN KEY ([SupplierID]) REFERENCES [dbo].[SupplierIdentifier] ([SupplierID])
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table contains 1 record for every Policy in the ePolicy system.', 'SCHEMA', N'dbo', 'TABLE', N'Policy', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the name of the consumer that will display on the dashboard.', 'SCHEMA', N'dbo', 'TABLE', N'Policy', 'COLUMN', N'ConsumerName'
GO
