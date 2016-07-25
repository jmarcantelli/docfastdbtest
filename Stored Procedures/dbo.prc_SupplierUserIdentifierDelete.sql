SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_SupplierUserIdentifierDelete]
(
	@SupplierID int,
	@UserID int,
	@IdentifyingValue nvarchar(200)
)
AS
	SET NOCOUNT ON

	DELETE 
	FROM   [SupplierUserIdentifier]
	WHERE  
		[SupplierID] = @SupplierID AND
		[UserID] = @UserID AND
		[IdentifyingValue] = @IdentifyingValue

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_SupplierUserIdentifierDelete] TO [PolicyEXDBReader]
GO
