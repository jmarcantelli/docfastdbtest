SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_PolicyAlertDelete]
(
	@PolicyAlertID bigint
)
AS
	SET NOCOUNT ON

	DELETE 
	FROM   [PolicyAlert]
	WHERE  
		[PolicyAlertID] = @PolicyAlertID

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_PolicyAlertDelete] TO [PolicyEXDBReader]
GO
