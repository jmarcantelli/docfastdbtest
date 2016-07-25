SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_PolicyAttachmentDelete]
(
	@AttachmentID bigint
)
AS
	SET NOCOUNT ON

	DELETE 
	FROM   [PolicyAttachment]
	WHERE  
		[AttachmentID] = @AttachmentID

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_PolicyAttachmentDelete] TO [PolicyEXDBReader]
GO
