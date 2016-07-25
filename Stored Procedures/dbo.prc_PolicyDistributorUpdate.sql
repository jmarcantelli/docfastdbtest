SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_PolicyDistributorUpdate]
(
	@PolicyID bigint,
	@DistributorID int,
	@OriginalDistributor bit,
	@CreatedBy nvarchar(50),
	@CreateDate datetime
)
AS
	SET NOCOUNT ON
	
	UPDATE [PolicyDistributor]
	SET
		[PolicyID] = @PolicyID,
		[DistributorID] = @DistributorID,
		[OriginalDistributor] = @OriginalDistributor,
		[CreatedBy] = @CreatedBy,
		[CreateDate] = @CreateDate
	WHERE 
		[PolicyID] = @PolicyID AND
		[DistributorID] = @DistributorID

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_PolicyDistributorUpdate] TO [PolicyEXDBReader]
GO
