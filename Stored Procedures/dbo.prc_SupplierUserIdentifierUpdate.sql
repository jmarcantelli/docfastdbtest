SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_SupplierUserIdentifierUpdate]
(
	@SupplierID int,
	@UserID int,
	@IdentifyingValue nvarchar(200),
	@CreatedBy nvarchar(50),
	@CreateDate datetime
)
AS
	SET NOCOUNT ON
	
	UPDATE [SupplierUserIdentifier]
	SET
		[SupplierID] = @SupplierID,
		[UserID] = @UserID,
		[IdentifyingValue] = @IdentifyingValue,
		[CreatedBy] = @CreatedBy,
		[CreateDate] = @CreateDate
	WHERE 
		[SupplierID] = @SupplierID AND
		[UserID] = @UserID AND
		[IdentifyingValue] = @IdentifyingValue

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_SupplierUserIdentifierUpdate] TO [PolicyEXDBReader]
GO
