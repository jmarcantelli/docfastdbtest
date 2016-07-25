SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_PolicyStatusDelete]
(
	@PolicyStatusID int
)
AS
	SET NOCOUNT ON

	DELETE 
	FROM   [PolicyStatus]
	WHERE  
		[PolicyStatusID] = @PolicyStatusID

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_PolicyStatusDelete] TO [PolicyEXDBReader]
GO
