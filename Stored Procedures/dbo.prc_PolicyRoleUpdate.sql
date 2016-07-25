SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_PolicyRoleUpdate]
(
	@PolicyRoleID smallint,
	@PolicyRoleName nvarchar(100)
)
AS
	SET NOCOUNT ON
	
	UPDATE [PolicyRole]
	SET
		[PolicyRoleID] = @PolicyRoleID,
		[PolicyRoleName] = @PolicyRoleName
	WHERE 
		[PolicyRoleID] = @PolicyRoleID

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_PolicyRoleUpdate] TO [PolicyEXDBReader]
GO
