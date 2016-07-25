SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_AlertTypeUpdate]
(
	@AlertTypeID int,
	@AlertType nvarchar(200)
)
AS
	SET NOCOUNT ON
	
	UPDATE [AlertType]
	SET
		[AlertTypeID] = @AlertTypeID,
		[AlertType] = @AlertType
	WHERE 
		[AlertTypeID] = @AlertTypeID

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_AlertTypeUpdate] TO [PolicyEXDBReader]
GO
