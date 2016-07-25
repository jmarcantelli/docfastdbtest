SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_DashboardActionsInsert]
(
	@DashboardActionID int = NULL OUTPUT,
	@UserTypeID smallint,
	@PolicyStatusID int,
	@PolicyRoleID smallint,
	@ActionID smallint
)
AS
	SET NOCOUNT ON

	INSERT INTO [DashboardActions]
	(
		[UserTypeID],
		[PolicyStatusID],
		[PolicyRoleID],
		[ActionID]
	)
	VALUES
	(
		@UserTypeID,
		@PolicyStatusID,
		@PolicyRoleID,
		@ActionID
	)

	SELECT @DashboardActionID = SCOPE_IDENTITY();

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_DashboardActionsInsert] TO [PolicyEXDBReader]
GO
