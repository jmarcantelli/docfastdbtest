SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_ConsumerRecipientDelete]
(
	@ConsumerRecipientID bigint
)
AS
	SET NOCOUNT ON

	DELETE 
	FROM   [ConsumerRecipient]
	WHERE  
		[ConsumerRecipientID] = @ConsumerRecipientID

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_ConsumerRecipientDelete] TO [PolicyEXDBReader]
GO
