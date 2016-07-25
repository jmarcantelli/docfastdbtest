SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_AlertTypeInsert]
(
	@AlertTypeID int,
	@AlertType nvarchar(200)
)
AS
	SET NOCOUNT ON

	INSERT INTO [AlertType]
	(
		[AlertTypeID],
		[AlertType]
	)
	VALUES
	(
		@AlertTypeID,
		@AlertType
	)

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_AlertTypeInsert] TO [PolicyEXDBReader]
GO
