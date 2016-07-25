SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_UserUpdate]
(
	@UserID int,
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
	
	UPDATE [User]
	SET
		[EmailAddress] = @EmailAddress,
		[UserTypeID] = @UserTypeID,
		[LoginName] = @LoginName,
		[FirstName] = @FirstName,
		[LastName] = @LastName,
		[SupplierID] = @SupplierID,
		[DistributorID] = @DistributorID,
		[CreatedBy] = @CreatedBy,
		[CreateDate] = @CreateDate
	WHERE 
		[UserID] = @UserID

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_UserUpdate] TO [PolicyEXDBReader]
GO
