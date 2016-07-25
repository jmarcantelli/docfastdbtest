SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_PolicyDistributorDelete]
(
	@PolicyID bigint,
	@DistributorID int
)
AS
	SET NOCOUNT ON

	DELETE 
	FROM   [PolicyDistributor]
	WHERE  
		[PolicyID] = @PolicyID AND
		[DistributorID] = @DistributorID

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_PolicyDistributorDelete] TO [PolicyEXDBReader]
GO
