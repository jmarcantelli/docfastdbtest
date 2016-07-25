SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_ActionInsert]
(
	@ActionID smallint,
	@Action nvarchar(100)
)
AS
	SET NOCOUNT ON

	INSERT INTO [Action]
	(
		[ActionID],
		[Action]
	)
	VALUES
	(
		@ActionID,
		@Action
	)

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_ActionInsert] TO [PolicyEXDBReader]
GO
