SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_SupplierDistributorIdentifierInsert]
(
	@DistributorID int,
	@SupplierID int,
	@IdentifyingValue nvarchar(200),
	@CreatedBy nvarchar(50),
	@CreateDate datetime
)
AS
	SET NOCOUNT ON

	INSERT INTO [SupplierDistributorIdentifier]
	(
		[DistributorID],
		[SupplierID],
		[IdentifyingValue],
		[CreatedBy],
		[CreateDate]
	)
	VALUES
	(
		@DistributorID,
		@SupplierID,
		@IdentifyingValue,
		@CreatedBy,
		@CreateDate
	)

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_SupplierDistributorIdentifierInsert] TO [PolicyEXDBReader]
GO
