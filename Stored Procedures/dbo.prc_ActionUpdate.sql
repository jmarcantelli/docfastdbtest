SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_ActionUpdate]
(
	@ActionID smallint,
	@Action nvarchar(100)
)
AS
	SET NOCOUNT ON
	
	UPDATE [Action]
	SET
		[ActionID] = @ActionID,
		[Action] = @Action
	WHERE 
		[ActionID] = @ActionID

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_ActionUpdate] TO [PolicyEXDBReader]
GO
