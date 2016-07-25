SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_UserTypeUpdate]
(
	@UserTypeID smallint,
	@UserTypeName nvarchar(100) = NULL
)
AS
	SET NOCOUNT ON
	
	UPDATE [UserType]
	SET
		[UserTypeID] = @UserTypeID,
		[UserTypeName] = @UserTypeName
	WHERE 
		[UserTypeID] = @UserTypeID

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_UserTypeUpdate] TO [PolicyEXDBReader]
GO
