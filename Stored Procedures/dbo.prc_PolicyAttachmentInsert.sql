SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_PolicyAttachmentInsert]
(
	@AttachmentID bigint = NULL OUTPUT,
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

	INSERT INTO [PolicyAttachment]
	(
		[PolicyID],
		[MimeTypeTC],
		[FileName],
		[DisplayOrder],
		[ACORDAttachmentTypeTC],
		[SupplierTemplateID],
		[CreatedBy],
		[CreateDate],
		[ModifiedBy],
		[ModifiedDate]
	)
	VALUES
	(
		@PolicyID,
		@MimeTypeTC,
		@FileName,
		@DisplayOrder,
		@ACORDAttachmentTypeTC,
		@SupplierTemplateID,
		@CreatedBy,
		@CreateDate,
		@ModifiedBy,
		@ModifiedDate
	)

	SELECT @AttachmentID = SCOPE_IDENTITY();

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_PolicyAttachmentInsert] TO [PolicyEXDBReader]
GO
