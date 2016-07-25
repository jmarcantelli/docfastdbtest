SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_PaymentModeDelete]
(
	@PaymentModeID tinyint
)
AS
	SET NOCOUNT ON

	DELETE 
	FROM   [PaymentMode]
	WHERE  
		[PaymentModeID] = @PaymentModeID

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_PaymentModeDelete] TO [PolicyEXDBReader]
GO
