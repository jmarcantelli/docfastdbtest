SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_PolicyActivityHistoryDelete]
(
	@PolicyActivityHistoryID bigint
)
AS
	SET NOCOUNT ON

	DELETE 
	FROM   [PolicyActivityHistory]
	WHERE  
		[PolicyActivityHistoryID] = @PolicyActivityHistoryID

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_PolicyActivityHistoryDelete] TO [PolicyEXDBReader]
GO
