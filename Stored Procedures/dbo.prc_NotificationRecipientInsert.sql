SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_NotificationRecipientInsert]
(
	@ActionID smallint,
	@PolicyStatusID int,
	@UserTypeID smallint,
	@PolicyDeliveryTypeID int,
	@ConfigurationKey nvarchar(100)
)
AS
	SET NOCOUNT ON

	INSERT INTO [NotificationRecipient]
	(
		[ActionID],
		[PolicyStatusID],
		[UserTypeID],
		[PolicyDeliveryTypeID],
		[ConfigurationKey]
	)
	VALUES
	(
		@ActionID,
		@PolicyStatusID,
		@UserTypeID,
		@PolicyDeliveryTypeID,
		@ConfigurationKey
	)

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_NotificationRecipientInsert] TO [PolicyEXDBReader]
GO
