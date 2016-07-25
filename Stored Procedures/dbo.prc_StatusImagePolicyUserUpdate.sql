SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_StatusImagePolicyUserUpdate]
(
	@StatusImagePolicyUserID int,
	@PolicyDeliveryTypeID int,
	@UserTypeID smallint,
	@PolicyRoleID smallint
)
AS
	SET NOCOUNT ON
	
	UPDATE [StatusImagePolicyUser]
	SET
		[PolicyDeliveryTypeID] = @PolicyDeliveryTypeID,
		[UserTypeID] = @UserTypeID,
		[PolicyRoleID] = @PolicyRoleID
	WHERE 
		[StatusImagePolicyUserID] = @StatusImagePolicyUserID

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_StatusImagePolicyUserUpdate] TO [PolicyEXDBReader]
GO
