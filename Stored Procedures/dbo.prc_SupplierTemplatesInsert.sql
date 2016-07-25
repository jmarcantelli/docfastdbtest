SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_SupplierTemplatesInsert]
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

	INSERT INTO [SupplierTemplates]
	(
		[SupplierTemplateID],
		[SupplierID],
		[Description],
		[TemplateXML],
		[TemplateUniqueID],
		[CreatedBy],
		[CreateDate],
		[ModifiedBy],
		[ModifiedDate]
	)
	VALUES
	(
		@SupplierTemplateID,
		@SupplierID,
		@Description,
		@TemplateXML,
		@TemplateUniqueID,
		@CreatedBy,
		@CreateDate,
		@ModifiedBy,
		@ModifiedDate
	)

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_SupplierTemplatesInsert] TO [PolicyEXDBReader]
GO
