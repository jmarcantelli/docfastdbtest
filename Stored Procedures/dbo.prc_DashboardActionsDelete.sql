SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_DashboardActionsDelete]
(
	@DashboardActionID int
)
AS
	SET NOCOUNT ON

	DELETE 
	FROM   [DashboardActions]
	WHERE  
		[DashboardActionID] = @DashboardActionID

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_DashboardActionsDelete] TO [PolicyEXDBReader]
GO
