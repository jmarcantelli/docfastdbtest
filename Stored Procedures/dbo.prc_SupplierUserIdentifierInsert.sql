SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_SupplierUserIdentifierInsert]
(
	@SupplierID int,
	@UserID int,
	@IdentifyingValue nvarchar(200),
	@CreatedBy nvarchar(50),
	@CreateDate datetime
)
AS
	SET NOCOUNT ON

	INSERT INTO [SupplierUserIdentifier]
	(
		[SupplierID],
		[UserID],
		[IdentifyingValue],
		[CreatedBy],
		[CreateDate]
	)
	VALUES
	(
		@SupplierID,
		@UserID,
		@IdentifyingValue,
		@CreatedBy,
		@CreateDate
	)

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_SupplierUserIdentifierInsert] TO [PolicyEXDBReader]
GO
