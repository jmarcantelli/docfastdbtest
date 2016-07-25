SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_PolicyDeliveryTypeInsert]
(
	@PolicyDeliveryTypeID int,
	@Description nvarchar(200)
)
AS
	SET NOCOUNT ON

	INSERT INTO [PolicyDeliveryType]
	(
		[PolicyDeliveryTypeID],
		[Description]
	)
	VALUES
	(
		@PolicyDeliveryTypeID,
		@Description
	)

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_PolicyDeliveryTypeInsert] TO [PolicyEXDBReader]
GO
