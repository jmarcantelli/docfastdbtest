SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_NotificationTemplateDelete]
(
	@NotificationTemplateID int
)
AS
	SET NOCOUNT ON

	DELETE 
	FROM   [NotificationTemplate]
	WHERE  
		[NotificationTemplateID] = @NotificationTemplateID

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_NotificationTemplateDelete] TO [PolicyEXDBReader]
GO
