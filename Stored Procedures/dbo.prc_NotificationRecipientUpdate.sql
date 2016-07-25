SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_NotificationRecipientUpdate]
(
	@ActionID smallint,
	@PolicyStatusID int,
	@UserTypeID smallint,
	@PolicyDeliveryTypeID int,
	@ConfigurationKey nvarchar(100)
)
AS
	SET NOCOUNT ON
	
	UPDATE [NotificationRecipient]
	SET
		[ActionID] = @ActionID,
		[PolicyStatusID] = @PolicyStatusID,
		[UserTypeID] = @UserTypeID,
		[PolicyDeliveryTypeID] = @PolicyDeliveryTypeID,
		[ConfigurationKey] = @ConfigurationKey
	WHERE 
		[ActionID] = @ActionID AND
		[PolicyStatusID] = @PolicyStatusID AND
		[UserTypeID] = @UserTypeID AND
		[PolicyDeliveryTypeID] = @PolicyDeliveryTypeID

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_NotificationRecipientUpdate] TO [PolicyEXDBReader]
GO
