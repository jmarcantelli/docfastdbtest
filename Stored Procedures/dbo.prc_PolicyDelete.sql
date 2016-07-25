SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_PolicyDelete]
(
	@PolicyID bigint
)
AS
	SET NOCOUNT ON

	DELETE 
	FROM   [Policy]
	WHERE  
		[PolicyID] = @PolicyID

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_PolicyDelete] TO [PolicyEXDBReader]
GO
