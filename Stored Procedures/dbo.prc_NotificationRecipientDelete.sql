SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_NotificationRecipientDelete]
(
	@ActionID smallint,
	@PolicyStatusID int,
	@UserTypeID smallint,
	@PolicyDeliveryTypeID int
)
AS
	SET NOCOUNT ON

	DELETE 
	FROM   [NotificationRecipient]
	WHERE  
		[ActionID] = @ActionID AND
		[PolicyStatusID] = @PolicyStatusID AND
		[UserTypeID] = @UserTypeID AND
		[PolicyDeliveryTypeID] = @PolicyDeliveryTypeID

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_NotificationRecipientDelete] TO [PolicyEXDBReader]
GO
