SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_SupplierPipePassIdentifierInsert]
(
	@SupplierID int,
	@SiteID int,
	@CreatedBy nvarchar(50),
	@CreateDate datetime
)
AS
	SET NOCOUNT ON

	INSERT INTO [SupplierPipePassIdentifier]
	(
		[SupplierID],
		[SiteID],
		[CreatedBy],
		[CreateDate]
	)
	VALUES
	(
		@SupplierID,
		@SiteID,
		@CreatedBy,
		@CreateDate
	)

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_SupplierPipePassIdentifierInsert] TO [PolicyEXDBReader]
GO
