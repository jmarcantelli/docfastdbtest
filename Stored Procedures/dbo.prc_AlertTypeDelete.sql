SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_AlertTypeDelete]
(
	@AlertTypeID int
)
AS
	SET NOCOUNT ON

	DELETE 
	FROM   [AlertType]
	WHERE  
		[AlertTypeID] = @AlertTypeID

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_AlertTypeDelete] TO [PolicyEXDBReader]
GO
