SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_StatusImageWorkflowInsert]
(
	@StatusImageWorkflowID int = NULL OUTPUT,
	@StatusImagePolicyUserID int,
	@PolicyStatusID int,
	@Figure varchar(20),
	@CssClass varchar(20),
	@FileName varchar(50)
)
AS
	SET NOCOUNT ON

	INSERT INTO [StatusImageWorkflow]
	(
		[StatusImagePolicyUserID],
		[PolicyStatusID],
		[Figure],
		[CssClass],
		[FileName]
	)
	VALUES
	(
		@StatusImagePolicyUserID,
		@PolicyStatusID,
		@Figure,
		@CssClass,
		@FileName
	)

	SELECT @StatusImageWorkflowID = SCOPE_IDENTITY();

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_StatusImageWorkflowInsert] TO [PolicyEXDBReader]
GO
