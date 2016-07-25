SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_PolicyUserUpdate]
(
	@PolicyID bigint,
	@UserID int,
	@PolicyRoleID smallint,
	@New bit = NULL,
	@CreatedBy nvarchar(50),
	@CreateDate datetime
)
AS
	SET NOCOUNT ON
	
	UPDATE [PolicyUser]
	SET
		[PolicyID] = @PolicyID,
		[UserID] = @UserID,
		[PolicyRoleID] = @PolicyRoleID,
		[New] = @New,
		[CreatedBy] = @CreatedBy,
		[CreateDate] = @CreateDate
	WHERE 
		[PolicyID] = @PolicyID AND
		[UserID] = @UserID

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_PolicyUserUpdate] TO [PolicyEXDBReader]
GO
