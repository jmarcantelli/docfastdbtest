SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_PolicyStatusUpdate]
(
	@PolicyStatusID int,
	@PolicyStatusName nvarchar(100) = NULL
)
AS
	SET NOCOUNT ON
	
	UPDATE [PolicyStatus]
	SET
		[PolicyStatusID] = @PolicyStatusID,
		[PolicyStatusName] = @PolicyStatusName
	WHERE 
		[PolicyStatusID] = @PolicyStatusID

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_PolicyStatusUpdate] TO [PolicyEXDBReader]
GO
