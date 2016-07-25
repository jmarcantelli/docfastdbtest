SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_KnockOutQuestionDelete]
(
	@QuestionID bigint
)
AS
	SET NOCOUNT ON

	DELETE 
	FROM   [KnockOutQuestion]
	WHERE  
		[QuestionID] = @QuestionID

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_KnockOutQuestionDelete] TO [PolicyEXDBReader]
GO
