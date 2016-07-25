SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_DistributorTypeInsert]
(
	@DistributorTypeID smallint,
	@Description nvarchar(200)
)
AS
	SET NOCOUNT ON

	INSERT INTO [DistributorType]
	(
		[DistributorTypeID],
		[Description]
	)
	VALUES
	(
		@DistributorTypeID,
		@Description
	)

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_DistributorTypeInsert] TO [PolicyEXDBReader]
GO
