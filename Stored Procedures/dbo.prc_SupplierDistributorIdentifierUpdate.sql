SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_SupplierDistributorIdentifierUpdate]
(
	@DistributorID int,
	@SupplierID int,
	@IdentifyingValue nvarchar(200),
	@CreatedBy nvarchar(50),
	@CreateDate datetime
)
AS
	SET NOCOUNT ON
	
	UPDATE [SupplierDistributorIdentifier]
	SET
		[DistributorID] = @DistributorID,
		[SupplierID] = @SupplierID,
		[IdentifyingValue] = @IdentifyingValue,
		[CreatedBy] = @CreatedBy,
		[CreateDate] = @CreateDate
	WHERE 
		[DistributorID] = @DistributorID AND
		[SupplierID] = @SupplierID AND
		[IdentifyingValue] = @IdentifyingValue

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_SupplierDistributorIdentifierUpdate] TO [PolicyEXDBReader]
GO
