SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_SupplierAllowedDashboardActionDelete]
(
	@SupplierID int,
	@DashboardActionID int
)
AS
	SET NOCOUNT ON

	DELETE 
	FROM   [SupplierAllowedDashboardAction]
	WHERE  
		[SupplierID] = @SupplierID AND
		[DashboardActionID] = @DashboardActionID

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_SupplierAllowedDashboardActionDelete] TO [PolicyEXDBReader]
GO
