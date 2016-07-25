SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_AlertCriteriaInsert]
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

	INSERT INTO [AlertCriteria]
	(
		[AlertCriteriaID],
		[AlertTypeID],
		[UserTypeID],
		[PolicyRoleID],
		[PolicyStatusID],
		[AlertRating],
		[AlertText],
		[DeliveryDateWithin],
		[NewFlag],
		[ExtensionRequest]
	)
	VALUES
	(
		@AlertCriteriaID,
		@AlertTypeID,
		@UserTypeID,
		@PolicyRoleID,
		@PolicyStatusID,
		@AlertRating,
		@AlertText,
		@DeliveryDateWithin,
		@NewFlag,
		@ExtensionRequest
	)

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_AlertCriteriaInsert] TO [PolicyEXDBReader]
GO
