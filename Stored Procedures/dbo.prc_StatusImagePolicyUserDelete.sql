SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_StatusImagePolicyUserDelete]
(
	@StatusImagePolicyUserID int
)
AS
	SET NOCOUNT ON

	DELETE 
	FROM   [StatusImagePolicyUser]
	WHERE  
		[StatusImagePolicyUserID] = @StatusImagePolicyUserID

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_StatusImagePolicyUserDelete] TO [PolicyEXDBReader]
GO
