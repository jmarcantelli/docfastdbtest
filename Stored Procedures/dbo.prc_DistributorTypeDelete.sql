SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_DistributorTypeDelete]
(
	@DistributorTypeID smallint
)
AS
	SET NOCOUNT ON

	DELETE 
	FROM   [DistributorType]
	WHERE  
		[DistributorTypeID] = @DistributorTypeID

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_DistributorTypeDelete] TO [PolicyEXDBReader]
GO
