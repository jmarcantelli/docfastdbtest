SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_SupplierDistributorIdentifierDelete]
(
	@DistributorID int,
	@SupplierID int,
	@IdentifyingValue nvarchar(200)
)
AS
	SET NOCOUNT ON

	DELETE 
	FROM   [SupplierDistributorIdentifier]
	WHERE  
		[DistributorID] = @DistributorID AND
		[SupplierID] = @SupplierID AND
		[IdentifyingValue] = @IdentifyingValue

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_SupplierDistributorIdentifierDelete] TO [PolicyEXDBReader]
GO
