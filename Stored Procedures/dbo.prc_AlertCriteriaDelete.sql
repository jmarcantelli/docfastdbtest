SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_AlertCriteriaDelete]
(
	@AlertCriteriaID int
)
AS
	SET NOCOUNT ON

	DELETE 
	FROM   [AlertCriteria]
	WHERE  
		[AlertCriteriaID] = @AlertCriteriaID

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_AlertCriteriaDelete] TO [PolicyEXDBReader]
GO
