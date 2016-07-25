SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_SupplierTemplatesUpdate]
(
	@SupplierTemplateID int,
	@SupplierID int,
	@Description nvarchar(200) = NULL,
	@TemplateXML nvarchar(max) = NULL,
	@TemplateUniqueID nvarchar(100) = NULL,
	@CreatedBy nvarchar(50),
	@CreateDate datetime,
	@ModifiedBy nvarchar(50),
	@ModifiedDate datetime
)
AS
	SET NOCOUNT ON
	
	UPDATE [SupplierTemplates]
	SET
		[SupplierTemplateID] = @SupplierTemplateID,
		[SupplierID] = @SupplierID,
		[Description] = @Description,
		[TemplateXML] = @TemplateXML,
		[TemplateUniqueID] = @TemplateUniqueID,
		[CreatedBy] = @CreatedBy,
		[CreateDate] = @CreateDate,
		[ModifiedBy] = @ModifiedBy,
		[ModifiedDate] = @ModifiedDate
	WHERE 
		[SupplierTemplateID] = @SupplierTemplateID

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_SupplierTemplatesUpdate] TO [PolicyEXDBReader]
GO
