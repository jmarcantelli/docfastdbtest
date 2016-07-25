SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_PolicyActivityHistoryInsert]
(
	@PolicyActivityHistoryID bigint = NULL OUTPUT,
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

	INSERT INTO [PolicyActivityHistory]
	(
		[PolicyID],
		[ActivityDate],
		[UserID],
		[ConsumerRecipientID],
		[PreviousPolicyStatusID],
		[NewPolicyStatusID]
	)
	VALUES
	(
		@PolicyID,
		@ActivityDate,
		@UserID,
		@ConsumerRecipientID,
		@PreviousPolicyStatusID,
		@NewPolicyStatusID
	)

	SELECT @PolicyActivityHistoryID = SCOPE_IDENTITY();

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_PolicyActivityHistoryInsert] TO [PolicyEXDBReader]
GO
