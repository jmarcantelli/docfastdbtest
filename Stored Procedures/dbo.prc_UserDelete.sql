SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_UserDelete]
(
	@UserID int
)
AS
	SET NOCOUNT ON

	DELETE 
	FROM   [User]
	WHERE  
		[UserID] = @UserID

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_UserDelete] TO [PolicyEXDBReader]
GO
