SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_PaymentModeInsert]
(
	@PaymentModeID tinyint,
	@PaymentMode nvarchar(200)
)
AS
	SET NOCOUNT ON

	INSERT INTO [PaymentMode]
	(
		[PaymentModeID],
		[PaymentMode]
	)
	VALUES
	(
		@PaymentModeID,
		@PaymentMode
	)

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_PaymentModeInsert] TO [PolicyEXDBReader]
GO
