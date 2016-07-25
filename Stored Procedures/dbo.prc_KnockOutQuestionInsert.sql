SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_KnockOutQuestionInsert]
(
	@QuestionID bigint = NULL OUTPUT,
	@ConsumerRecipientID bigint,
	@Ordinal int,
	@QuestionText nvarchar(max),
	@ResponseDetail nvarchar(max) = NULL,
	@CreatedBy nvarchar(50),
	@CreateDate datetime,
	@ModifiedBy nvarchar(50),
	@ModifiedDate datetime
)
AS
	SET NOCOUNT ON

	INSERT INTO [KnockOutQuestion]
	(
		[ConsumerRecipientID],
		[Ordinal],
		[QuestionText],
		[ResponseDetail],
		[CreatedBy],
		[CreateDate],
		[ModifiedBy],
		[ModifiedDate]
	)
	VALUES
	(
		@ConsumerRecipientID,
		@Ordinal,
		@QuestionText,
		@ResponseDetail,
		@CreatedBy,
		@CreateDate,
		@ModifiedBy,
		@ModifiedDate
	)

	SELECT @QuestionID = SCOPE_IDENTITY();

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_KnockOutQuestionInsert] TO [PolicyEXDBReader]
GO
