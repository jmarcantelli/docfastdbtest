SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_KnockOutAnswerChoiceInsert]
(
	@AnswerID bigint = NULL OUTPUT,
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

	INSERT INTO [KnockOutAnswerChoice]
	(
		[QuestionID],
		[Ordinal],
		[AnswerChoiceText],
		[KnockOutAnswer],
		[DetailOnAnswer],
		[SelectedAnswer],
		[AnswerDate],
		[CreatedBy],
		[CreateDate],
		[ModifiedBy],
		[ModifiedDate]
	)
	VALUES
	(
		@QuestionID,
		@Ordinal,
		@AnswerChoiceText,
		@KnockOutAnswer,
		@DetailOnAnswer,
		@SelectedAnswer,
		@AnswerDate,
		@CreatedBy,
		@CreateDate,
		@ModifiedBy,
		@ModifiedDate
	)

	SELECT @AnswerID = SCOPE_IDENTITY();

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_KnockOutAnswerChoiceInsert] TO [PolicyEXDBReader]
GO
