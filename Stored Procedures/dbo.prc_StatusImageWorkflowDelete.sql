SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_StatusImageWorkflowDelete]
(
	@StatusImageWorkflowID int
)
AS
	SET NOCOUNT ON

	DELETE 
	FROM   [StatusImageWorkflow]
	WHERE  
		[StatusImageWorkflowID] = @StatusImageWorkflowID

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_StatusImageWorkflowDelete] TO [PolicyEXDBReader]
GO
