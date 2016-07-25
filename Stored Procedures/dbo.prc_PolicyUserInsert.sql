SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_PolicyUserInsert]
(
	@PolicyID bigint,
	@UserID int,
	@PolicyRoleID smallint,
	@New bit = NULL,
	@CreatedBy nvarchar(50),
	@CreateDate datetime
)
AS
	SET NOCOUNT ON

	INSERT INTO [PolicyUser]
	(
		[PolicyID],
		[UserID],
		[PolicyRoleID],
		[New],
		[CreatedBy],
		[CreateDate]
	)
	VALUES
	(
		@PolicyID,
		@UserID,
		@PolicyRoleID,
		@New,
		@CreatedBy,
		@CreateDate
	)

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_PolicyUserInsert] TO [PolicyEXDBReader]
GO
