SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_PolicyAttachmentUpdate]
(
	@AttachmentID bigint,
	@PolicyID bigint,
	@MimeTypeTC int,
	@FileName nvarchar(200),
	@DisplayOrder int,
	@ACORDAttachmentTypeTC int = NULL,
	@SupplierTemplateID int = NULL,
	@CreatedBy nvarchar(50),
	@CreateDate datetime,
	@ModifiedBy nvarchar(50),
	@ModifiedDate datetime
)
AS
	SET NOCOUNT ON
	
	UPDATE [PolicyAttachment]
	SET
		[PolicyID] = @PolicyID,
		[MimeTypeTC] = @MimeTypeTC,
		[FileName] = @FileName,
		[DisplayOrder] = @DisplayOrder,
		[ACORDAttachmentTypeTC] = @ACORDAttachmentTypeTC,
		[SupplierTemplateID] = @SupplierTemplateID,
		[CreatedBy] = @CreatedBy,
		[CreateDate] = @CreateDate,
		[ModifiedBy] = @ModifiedBy,
		[ModifiedDate] = @ModifiedDate
	WHERE 
		[AttachmentID] = @AttachmentID

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_PolicyAttachmentUpdate] TO [PolicyEXDBReader]
GO
