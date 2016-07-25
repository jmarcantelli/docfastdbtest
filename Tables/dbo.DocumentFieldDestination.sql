CREATE TABLE [dbo].[DocumentFieldDestination]
(
[DocumentFieldMappingID] [int] NOT NULL,
[DestinationType] [int] NOT NULL,
[PriorityOrder] [smallint] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DocumentFieldDestination] ADD CONSTRAINT [PK_DocumentFieldDestination_1] PRIMARY KEY CLUSTERED  ([DocumentFieldMappingID], [DestinationType]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DocumentFieldDestination] ADD CONSTRAINT [uc_DocumentFieldDestinationType] UNIQUE NONCLUSTERED  ([DocumentFieldMappingID], [DestinationType]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DocumentFieldDestination] ADD CONSTRAINT [FK_DocumentFieldDestination_DocumentFieldMapping] FOREIGN KEY ([DocumentFieldMappingID]) REFERENCES [dbo].[DocumentFieldMapping] ([DocumentFieldMappingId])
GO
