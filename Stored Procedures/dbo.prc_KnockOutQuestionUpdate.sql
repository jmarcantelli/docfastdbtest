SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_KnockOutQuestionUpdate]
(
	@QuestionID bigint,
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
	
	UPDATE [KnockOutQuestion]
	SET
		[ConsumerRecipientID] = @ConsumerRecipientID,
		[Ordinal] = @Ordinal,
		[QuestionText] = @QuestionText,
		[ResponseDetail] = @ResponseDetail,
		[CreatedBy] = @CreatedBy,
		[CreateDate] = @CreateDate,
		[ModifiedBy] = @ModifiedBy,
		[ModifiedDate] = @ModifiedDate
	WHERE 
		[QuestionID] = @QuestionID

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_KnockOutQuestionUpdate] TO [PolicyEXDBReader]
GO
