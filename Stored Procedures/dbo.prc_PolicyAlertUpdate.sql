SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_PolicyAlertUpdate]
(
	@PolicyAlertID bigint,
	@PolicyID bigint = NULL,
	@UserID int = NULL,
	@AlertTypeID int = NULL,
	@AlertText nvarchar(500) = NULL,
	@AlertRating tinyint = NULL
)
AS
	SET NOCOUNT ON
	
	UPDATE [PolicyAlert]
	SET
		[PolicyID] = @PolicyID,
		[UserID] = @UserID,
		[AlertTypeID] = @AlertTypeID,
		[AlertText] = @AlertText,
		[AlertRating] = @AlertRating
	WHERE 
		[PolicyAlertID] = @PolicyAlertID

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_PolicyAlertUpdate] TO [PolicyEXDBReader]
GO
