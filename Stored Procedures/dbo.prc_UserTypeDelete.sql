SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_UserTypeDelete]
(
	@UserTypeID smallint
)
AS
	SET NOCOUNT ON

	DELETE 
	FROM   [UserType]
	WHERE  
		[UserTypeID] = @UserTypeID

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_UserTypeDelete] TO [PolicyEXDBReader]
GO
