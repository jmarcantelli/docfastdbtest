SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_PolicyUserDelete]
(
	@PolicyID bigint,
	@UserID int
)
AS
	SET NOCOUNT ON

	DELETE 
	FROM   [PolicyUser]
	WHERE  
		[PolicyID] = @PolicyID AND
		[UserID] = @UserID

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_PolicyUserDelete] TO [PolicyEXDBReader]
GO
