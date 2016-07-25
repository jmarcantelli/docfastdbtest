SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_AlertCriteriaUpdate]
(
	@AlertCriteriaID int,
	@AlertTypeID int,
	@UserTypeID smallint = NULL,
	@PolicyRoleID smallint = NULL,
	@PolicyStatusID int = NULL,
	@AlertRating smallint = NULL,
	@AlertText nvarchar(max) = NULL,
	@DeliveryDateWithin smallint = NULL,
	@NewFlag bit = NULL,
	@ExtensionRequest bit = NULL
)
AS
	SET NOCOUNT ON
	
	UPDATE [AlertCriteria]
	SET
		[AlertCriteriaID] = @AlertCriteriaID,
		[AlertTypeID] = @AlertTypeID,
		[UserTypeID] = @UserTypeID,
		[PolicyRoleID] = @PolicyRoleID,
		[PolicyStatusID] = @PolicyStatusID,
		[AlertRating] = @AlertRating,
		[AlertText] = @AlertText,
		[DeliveryDateWithin] = @DeliveryDateWithin,
		[NewFlag] = @NewFlag,
		[ExtensionRequest] = @ExtensionRequest
	WHERE 
		[AlertCriteriaID] = @AlertCriteriaID

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_AlertCriteriaUpdate] TO [PolicyEXDBReader]
GO
