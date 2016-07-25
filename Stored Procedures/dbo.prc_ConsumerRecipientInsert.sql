SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_ConsumerRecipientInsert]
(
	@ConsumerRecipientID bigint = NULL OUTPUT,
	@PolicyID bigint,
	@FirstName nvarchar(200),
	@LastName nvarchar(200),
	@EmailAddress nvarchar(500),
	@AuthenticationChallengeValue nvarchar(50),
	@UniqueID uniqueidentifier = NULL,
	@UniqueFailCount tinyint = NULL,
	@DocuSignStatusID smallint = NULL,
	@PaymentInfo xml = NULL,
	@PaymentAmount money = NULL,
	@PremiumAmount money = NULL,
	@PaymentModeID tinyint = NULL,
	@Active bit
)
AS
	SET NOCOUNT ON

	INSERT INTO [ConsumerRecipient]
	(
		[PolicyID],
		[FirstName],
		[LastName],
		[EmailAddress],
		[AuthenticationChallengeValue],
		[UniqueID],
		[UniqueFailCount],
		[DocuSignStatusID],
		[PaymentInfo],
		[PaymentAmount],
		[PremiumAmount],
		[PaymentModeID],
		[Active]
	)
	VALUES
	(
		@PolicyID,
		@FirstName,
		@LastName,
		@EmailAddress,
		@AuthenticationChallengeValue,
		@UniqueID,
		@UniqueFailCount,
		@DocuSignStatusID,
		@PaymentInfo,
		@PaymentAmount,
		@PremiumAmount,
		@PaymentModeID,
		@Active
	)

	SELECT @ConsumerRecipientID = SCOPE_IDENTITY();

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_ConsumerRecipientInsert] TO [PolicyEXDBReader]
GO
