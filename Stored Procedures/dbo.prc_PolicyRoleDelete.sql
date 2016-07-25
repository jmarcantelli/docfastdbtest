SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_PolicyRoleDelete]
(
	@PolicyRoleID smallint
)
AS
	SET NOCOUNT ON

	DELETE 
	FROM   [PolicyRole]
	WHERE  
		[PolicyRoleID] = @PolicyRoleID

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_PolicyRoleDelete] TO [PolicyEXDBReader]
GO
