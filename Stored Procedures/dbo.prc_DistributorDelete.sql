SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_DistributorDelete]
(
	@DistributorID int
)
AS
	SET NOCOUNT ON

	DELETE 
	FROM   [Distributor]
	WHERE  
		[DistributorID] = @DistributorID

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_DistributorDelete] TO [PolicyEXDBReader]
GO
