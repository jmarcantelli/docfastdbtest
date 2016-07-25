SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_DistributorTypeUpdate]
(
	@DistributorTypeID smallint,
	@Description nvarchar(200)
)
AS
	SET NOCOUNT ON
	
	UPDATE [DistributorType]
	SET
		[DistributorTypeID] = @DistributorTypeID,
		[Description] = @Description
	WHERE 
		[DistributorTypeID] = @DistributorTypeID

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_DistributorTypeUpdate] TO [PolicyEXDBReader]
GO
