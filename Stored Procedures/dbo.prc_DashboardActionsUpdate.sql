SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_DashboardActionsUpdate]
(
	@DashboardActionID int,
	@UserTypeID smallint,
	@PolicyStatusID int,
	@PolicyRoleID smallint,
	@ActionID smallint
)
AS
	SET NOCOUNT ON
	
	UPDATE [DashboardActions]
	SET
		[UserTypeID] = @UserTypeID,
		[PolicyStatusID] = @PolicyStatusID,
		[PolicyRoleID] = @PolicyRoleID,
		[ActionID] = @ActionID
	WHERE 
		[DashboardActionID] = @DashboardActionID

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_DashboardActionsUpdate] TO [PolicyEXDBReader]
GO
