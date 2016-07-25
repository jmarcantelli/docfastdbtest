SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_PolicyStatusInsert]
(
	@PolicyStatusID int,
	@PolicyStatusName nvarchar(100) = NULL
)
AS
	SET NOCOUNT ON

	INSERT INTO [PolicyStatus]
	(
		[PolicyStatusID],
		[PolicyStatusName]
	)
	VALUES
	(
		@PolicyStatusID,
		@PolicyStatusName
	)

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_PolicyStatusInsert] TO [PolicyEXDBReader]
GO
