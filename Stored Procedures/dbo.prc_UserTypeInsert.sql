SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_UserTypeInsert]
(
	@UserTypeID smallint,
	@UserTypeName nvarchar(100) = NULL
)
AS
	SET NOCOUNT ON

	INSERT INTO [UserType]
	(
		[UserTypeID],
		[UserTypeName]
	)
	VALUES
	(
		@UserTypeID,
		@UserTypeName
	)

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_UserTypeInsert] TO [PolicyEXDBReader]
GO
