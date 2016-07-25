SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_SupplierPipePassIdentifierDelete]
(
	@SupplierID int
)
AS
	SET NOCOUNT ON

	DELETE 
	FROM   [SupplierPipePassIdentifier]
	WHERE  
		[SupplierID] = @SupplierID

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_SupplierPipePassIdentifierDelete] TO [PolicyEXDBReader]
GO
