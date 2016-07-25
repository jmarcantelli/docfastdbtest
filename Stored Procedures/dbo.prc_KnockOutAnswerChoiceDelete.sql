SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_KnockOutAnswerChoiceDelete]
(
	@AnswerID bigint
)
AS
	SET NOCOUNT ON

	DELETE 
	FROM   [KnockOutAnswerChoice]
	WHERE  
		[AnswerID] = @AnswerID

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_KnockOutAnswerChoiceDelete] TO [PolicyEXDBReader]
GO
