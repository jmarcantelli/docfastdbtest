SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_StatusImagePolicyUserInsert]
(
	@StatusImagePolicyUserID int = NULL OUTPUT,
	@PolicyDeliveryTypeID int,
	@UserTypeID smallint,
	@PolicyRoleID smallint
)
AS
	SET NOCOUNT ON

	INSERT INTO [StatusImagePolicyUser]
	(
		[PolicyDeliveryTypeID],
		[UserTypeID],
		[PolicyRoleID]
	)
	VALUES
	(
		@PolicyDeliveryTypeID,
		@UserTypeID,
		@PolicyRoleID
	)

	SELECT @StatusImagePolicyUserID = SCOPE_IDENTITY();

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_StatusImagePolicyUserInsert] TO [PolicyEXDBReader]
GO
