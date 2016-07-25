SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_NotificationTemplateUpdate]
(
	@NotificationTemplateID int,
	@TemplateName varchar(100),
	@TemplateXSL varchar(max) = NULL
)
AS
	SET NOCOUNT ON
	
	UPDATE [NotificationTemplate]
	SET
		[TemplateName] = @TemplateName,
		[TemplateXSL] = @TemplateXSL
	WHERE 
		[NotificationTemplateID] = @NotificationTemplateID

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_NotificationTemplateUpdate] TO [PolicyEXDBReader]
GO
