SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_StatusImageWorkflowUpdate]
(
	@StatusImageWorkflowID int,
	@StatusImagePolicyUserID int,
	@PolicyStatusID int,
	@Figure varchar(20),
	@CssClass varchar(20),
	@FileName varchar(50)
)
AS
	SET NOCOUNT ON
	
	UPDATE [StatusImageWorkflow]
	SET
		[StatusImagePolicyUserID] = @StatusImagePolicyUserID,
		[PolicyStatusID] = @PolicyStatusID,
		[Figure] = @Figure,
		[CssClass] = @CssClass,
		[FileName] = @FileName
	WHERE 
		[StatusImageWorkflowID] = @StatusImageWorkflowID

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_StatusImageWorkflowUpdate] TO [PolicyEXDBReader]
GO
