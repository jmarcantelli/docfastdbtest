SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_SupplierIdentifierUpdate]
(
	@SupplierID int,
	@CarrierCode varchar(100),
	@CreatedBy nvarchar(50),
	@CreateDate datetime
)
AS
	SET NOCOUNT ON
	
	UPDATE [SupplierIdentifier]
	SET
		[SupplierID] = @SupplierID,
		[CarrierCode] = @CarrierCode,
		[CreatedBy] = @CreatedBy,
		[CreateDate] = @CreateDate
	WHERE 
		[SupplierID] = @SupplierID AND
		[CarrierCode] = @CarrierCode

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_SupplierIdentifierUpdate] TO [PolicyEXDBReader]
GO
