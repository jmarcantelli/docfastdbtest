SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_PaymentModeUpdate]
(
	@PaymentModeID tinyint,
	@PaymentMode nvarchar(200)
)
AS
	SET NOCOUNT ON
	
	UPDATE [PaymentMode]
	SET
		[PaymentModeID] = @PaymentModeID,
		[PaymentMode] = @PaymentMode
	WHERE 
		[PaymentModeID] = @PaymentModeID

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_PaymentModeUpdate] TO [PolicyEXDBReader]
GO
