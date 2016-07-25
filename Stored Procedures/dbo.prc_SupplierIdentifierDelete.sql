SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_SupplierIdentifierDelete]
(
	@SupplierID int,
	@CarrierCode varchar(100)
)
AS
	SET NOCOUNT ON

	DELETE 
	FROM   [SupplierIdentifier]
	WHERE  
		[SupplierID] = @SupplierID AND
		[CarrierCode] = @CarrierCode

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_SupplierIdentifierDelete] TO [PolicyEXDBReader]
GO
