SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_PolicyRoleInsert]
(
	@PolicyRoleID smallint,
	@PolicyRoleName nvarchar(100)
)
AS
	SET NOCOUNT ON

	INSERT INTO [PolicyRole]
	(
		[PolicyRoleID],
		[PolicyRoleName]
	)
	VALUES
	(
		@PolicyRoleID,
		@PolicyRoleName
	)

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_PolicyRoleInsert] TO [PolicyEXDBReader]
GO
