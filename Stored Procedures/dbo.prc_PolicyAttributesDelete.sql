SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_PolicyAttributesDelete]
(
	@PolicyID bigint,
	@AttributeKey nvarchar(200)
)
AS
	SET NOCOUNT ON

	DELETE 
	FROM   [PolicyAttributes]
	WHERE  
		[PolicyID] = @PolicyID AND
		[AttributeKey] = @AttributeKey

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_PolicyAttributesDelete] TO [PolicyEXDBReader]
GO
