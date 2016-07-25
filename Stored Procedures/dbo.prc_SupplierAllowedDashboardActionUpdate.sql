SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_SupplierAllowedDashboardActionUpdate]
(
	@SupplierID int,
	@DashboardActionID int
)
AS
	SET NOCOUNT ON
	
	UPDATE [SupplierAllowedDashboardAction]
	SET
		[SupplierID] = @SupplierID,
		[DashboardActionID] = @DashboardActionID
	WHERE 
		[SupplierID] = @SupplierID AND
		[DashboardActionID] = @DashboardActionID

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_SupplierAllowedDashboardActionUpdate] TO [PolicyEXDBReader]
GO
