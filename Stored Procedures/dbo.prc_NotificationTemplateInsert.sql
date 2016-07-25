SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_NotificationTemplateInsert]
(
	@NotificationTemplateID int = NULL OUTPUT,
	@TemplateName varchar(100),
	@TemplateXSL varchar(max) = NULL
)
AS
	SET NOCOUNT ON

	INSERT INTO [NotificationTemplate]
	(
		[TemplateName],
		[TemplateXSL]
	)
	VALUES
	(
		@TemplateName,
		@TemplateXSL
	)

	SELECT @NotificationTemplateID = SCOPE_IDENTITY();

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_NotificationTemplateInsert] TO [PolicyEXDBReader]
GO
