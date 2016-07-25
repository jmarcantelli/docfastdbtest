SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_PolicyActivityHistoryUpdate]
(
	@PolicyActivityHistoryID bigint,
	@PolicyID bigint,
	@ActivityDate datetime,
	@UserID int = NULL,
	@ConsumerRecipientID bigint = NULL,
	@Activity nvarchar(max),
	@PreviousPolicyStatusID int = NULL,
	@NewPolicyStatusID int = NULL
)
AS
	SET NOCOUNT ON
	
	UPDATE [PolicyActivityHistory]
	SET
		[PolicyID] = @PolicyID,
		[ActivityDate] = @ActivityDate,
		[UserID] = @UserID,
		[ConsumerRecipientID] = @ConsumerRecipientID,
		[PreviousPolicyStatusID] = @PreviousPolicyStatusID,
		[NewPolicyStatusID] = @NewPolicyStatusID
	WHERE 
		[PolicyActivityHistoryID] = @PolicyActivityHistoryID

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_PolicyActivityHistoryUpdate] TO [PolicyEXDBReader]
GO
