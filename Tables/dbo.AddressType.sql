CREATE TABLE [dbo].[AddressType]
(
[AddressTypeID] [smallint] NOT NULL,
[AddressTypeName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CreatedBy] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CreateDate] [datetime] NOT NULL,
[ModifiedBy] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ModifiedDate] [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AddressType] ADD CONSTRAINT [PK_AddressType] PRIMARY KEY CLUSTERED  ([AddressTypeID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AddressType] ADD CONSTRAINT [UC_AddressTypeName] UNIQUE NONCLUSTERED  ([AddressTypeName]) ON [PRIMARY]
GO
