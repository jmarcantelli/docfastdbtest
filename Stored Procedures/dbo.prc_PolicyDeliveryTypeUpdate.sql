SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_PolicyDeliveryTypeUpdate]
(
	@PolicyDeliveryTypeID int,
	@Description nvarchar(200)
)
AS
	SET NOCOUNT ON
	
	UPDATE [PolicyDeliveryType]
	SET
		[PolicyDeliveryTypeID] = @PolicyDeliveryTypeID,
		[Description] = @Description
	WHERE 
		[PolicyDeliveryTypeID] = @PolicyDeliveryTypeID

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_PolicyDeliveryTypeUpdate] TO [PolicyEXDBReader]
GO
