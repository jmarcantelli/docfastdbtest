SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_SupplierPipePassIdentifierUpdate]
(
	@SupplierID int,
	@SiteID int,
	@CreatedBy nvarchar(50),
	@CreateDate datetime
)
AS
	SET NOCOUNT ON
	
	UPDATE [SupplierPipePassIdentifier]
	SET
		[SupplierID] = @SupplierID,
		[SiteID] = @SiteID,
		[CreatedBy] = @CreatedBy,
		[CreateDate] = @CreateDate
	WHERE 
		[SupplierID] = @SupplierID

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_SupplierPipePassIdentifierUpdate] TO [PolicyEXDBReader]
GO
