SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_PolicyAttributesInsert]
(
	@PolicyID bigint,
	@AttributeKey nvarchar(200),
	@AttributeLabel nvarchar(200) = NULL,
	@AttributeValue nvarchar(500) = NULL,
	@Display bit = NULL
)
AS
	SET NOCOUNT ON

	INSERT INTO [PolicyAttributes]
	(
		[PolicyID],
		[AttributeKey],
		[AttributeLabel],
		[AttributeValue],
		[Display]
	)
	VALUES
	(
		@PolicyID,
		@AttributeKey,
		@AttributeLabel,
		@AttributeValue,
		@Display
	)

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_PolicyAttributesInsert] TO [PolicyEXDBReader]
GO
