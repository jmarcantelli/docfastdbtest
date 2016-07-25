SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_SupplierTemplatesDelete]
(
	@SupplierTemplateID int
)
AS
	SET NOCOUNT ON

	DELETE 
	FROM   [SupplierTemplates]
	WHERE  
		[SupplierTemplateID] = @SupplierTemplateID

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_SupplierTemplatesDelete] TO [PolicyEXDBReader]
GO
