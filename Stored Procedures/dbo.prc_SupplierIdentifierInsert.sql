SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_SupplierIdentifierInsert]
(
	@SupplierID int,
	@CarrierCode varchar(100),
	@CreatedBy nvarchar(50),
	@CreateDate datetime
)
AS
	SET NOCOUNT ON

	INSERT INTO [SupplierIdentifier]
	(
		[SupplierID],
		[CarrierCode],
		[CreatedBy],
		[CreateDate]
	)
	VALUES
	(
		@SupplierID,
		@CarrierCode,
		@CreatedBy,
		@CreateDate
	)

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_SupplierIdentifierInsert] TO [PolicyEXDBReader]
GO
