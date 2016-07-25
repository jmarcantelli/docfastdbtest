SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_UserInsert]
(
	@UserID int = NULL OUTPUT,
	@EmailAddress nvarchar(500) = NULL,
	@UserTypeID smallint = NULL,
	@LoginName nvarchar(200) = NULL,
	@FirstName nvarchar(100),
	@LastName nvarchar(100),
	@SupplierID int = NULL,
	@DistributorID int = NULL,
	@CreatedBy nvarchar(50),
	@CreateDate datetime
)
AS
	SET NOCOUNT ON

	INSERT INTO [User]
	(
		[EmailAddress],
		[UserTypeID],
		[LoginName],
		[FirstName],
		[LastName],
		[SupplierID],
		[DistributorID],
		[CreatedBy],
		[CreateDate]
	)
	VALUES
	(
		@EmailAddress,
		@UserTypeID,
		@LoginName,
		@FirstName,
		@LastName,
		@SupplierID,
		@DistributorID,
		@CreatedBy,
		@CreateDate
	)

	SELECT @UserID = SCOPE_IDENTITY();

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_UserInsert] TO [PolicyEXDBReader]
GO
