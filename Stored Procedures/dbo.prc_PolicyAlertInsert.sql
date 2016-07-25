SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_PolicyAlertInsert]
(
	@PolicyAlertID bigint = NULL OUTPUT,
	@PolicyID bigint = NULL,
	@UserID int = NULL,
	@AlertTypeID int = NULL,
	@AlertText nvarchar(500) = NULL,
	@AlertRating tinyint = NULL
)
AS
	SET NOCOUNT ON

	INSERT INTO [PolicyAlert]
	(
		[PolicyID],
		[UserID],
		[AlertTypeID],
		[AlertText],
		[AlertRating]
	)
	VALUES
	(
		@PolicyID,
		@UserID,
		@AlertTypeID,
		@AlertText,
		@AlertRating
	)

	SELECT @PolicyAlertID = SCOPE_IDENTITY();

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_PolicyAlertInsert] TO [PolicyEXDBReader]
GO
