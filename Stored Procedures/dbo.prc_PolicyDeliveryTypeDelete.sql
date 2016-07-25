SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_PolicyDeliveryTypeDelete]
(
	@PolicyDeliveryTypeID int
)
AS
	SET NOCOUNT ON

	DELETE 
	FROM   [PolicyDeliveryType]
	WHERE  
		[PolicyDeliveryTypeID] = @PolicyDeliveryTypeID

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_PolicyDeliveryTypeDelete] TO [PolicyEXDBReader]
GO
