SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_ConsumerRecipientUpdate]
(
	@ConsumerRecipientID bigint,
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
	
	UPDATE [ConsumerRecipient]
	SET
		[PolicyID] = @PolicyID,
		[FirstName] = @FirstName,
		[LastName] = @LastName,
		[EmailAddress] = @EmailAddress,
		[AuthenticationChallengeValue] = @AuthenticationChallengeValue,
		[UniqueID] = @UniqueID,
		[UniqueFailCount] = @UniqueFailCount,
		[DocuSignStatusID] = @DocuSignStatusID,
		[PaymentInfo] = @PaymentInfo,
		[PaymentAmount] = @PaymentAmount,
		[PremiumAmount] = @PremiumAmount,
		[PaymentModeID] = @PaymentModeID,
		[Active] = @Active
	WHERE 
		[ConsumerRecipientID] = @ConsumerRecipientID

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_ConsumerRecipientUpdate] TO [PolicyEXDBReader]
GO
