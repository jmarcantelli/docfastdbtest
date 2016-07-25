SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_SupplierAllowedDashboardActionInsert]
(
	@SupplierID int,
	@DashboardActionID int
)
AS
	SET NOCOUNT ON

	INSERT INTO [SupplierAllowedDashboardAction]
	(
		[SupplierID],
		[DashboardActionID]
	)
	VALUES
	(
		@SupplierID,
		@DashboardActionID
	)

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_SupplierAllowedDashboardActionInsert] TO [PolicyEXDBReader]
GO
