SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_KnockOutAnswerChoiceUpdate]
(
	@AnswerID bigint,
	@QuestionID bigint,
	@Ordinal int,
	@AnswerChoiceText nvarchar(100) = NULL,
	@KnockOutAnswer bit,
	@DetailOnAnswer bit,
	@SelectedAnswer bit = NULL,
	@AnswerDate datetime = NULL,
	@CreatedBy nvarchar(50),
	@CreateDate datetime,
	@ModifiedBy nvarchar(50),
	@ModifiedDate datetime
)
AS
	SET NOCOUNT ON
	
	UPDATE [KnockOutAnswerChoice]
	SET
		[QuestionID] = @QuestionID,
		[Ordinal] = @Ordinal,
		[AnswerChoiceText] = @AnswerChoiceText,
		[KnockOutAnswer] = @KnockOutAnswer,
		[DetailOnAnswer] = @DetailOnAnswer,
		[SelectedAnswer] = @SelectedAnswer,
		[AnswerDate] = @AnswerDate,
		[CreatedBy] = @CreatedBy,
		[CreateDate] = @CreateDate,
		[ModifiedBy] = @ModifiedBy,
		[ModifiedDate] = @ModifiedDate
	WHERE 
		[AnswerID] = @AnswerID

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_KnockOutAnswerChoiceUpdate] TO [PolicyEXDBReader]
GO
