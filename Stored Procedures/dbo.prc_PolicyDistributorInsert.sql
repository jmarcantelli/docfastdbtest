SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_PolicyDistributorInsert]
(
	@PolicyID bigint,
	@DistributorID int,
	@OriginalDistributor bit,
	@CreatedBy nvarchar(50),
	@CreateDate datetime
)
AS
	SET NOCOUNT ON

	INSERT INTO [PolicyDistributor]
	(
		[PolicyID],
		[DistributorID],
		[OriginalDistributor],
		[CreatedBy],
		[CreateDate]
	)
	VALUES
	(
		@PolicyID,
		@DistributorID,
		@OriginalDistributor,
		@CreatedBy,
		@CreateDate
	)

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_PolicyDistributorInsert] TO [PolicyEXDBReader]
GO
