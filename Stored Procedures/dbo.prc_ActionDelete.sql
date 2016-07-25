SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_ActionDelete]
(
	@ActionID smallint
)
AS
	SET NOCOUNT ON

	DELETE 
	FROM   [Action]
	WHERE  
		[ActionID] = @ActionID

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_ActionDelete] TO [PolicyEXDBReader]
GO
