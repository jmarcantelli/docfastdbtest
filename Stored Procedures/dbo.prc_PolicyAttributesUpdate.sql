SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_PolicyAttributesUpdate]
(
	@PolicyID bigint,
	@AttributeKey nvarchar(200),
	@AttributeLabel nvarchar(200) = NULL,
	@AttributeValue nvarchar(500) = NULL,
	@Display bit = NULL
)
AS
	SET NOCOUNT ON
	
	UPDATE [PolicyAttributes]
	SET
		[PolicyID] = @PolicyID,
		[AttributeKey] = @AttributeKey,
		[AttributeLabel] = @AttributeLabel,
		[AttributeValue] = @AttributeValue,
		[Display] = @Display
	WHERE 
		[PolicyID] = @PolicyID AND
		[AttributeKey] = @AttributeKey

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_PolicyAttributesUpdate] TO [PolicyEXDBReader]
GO
