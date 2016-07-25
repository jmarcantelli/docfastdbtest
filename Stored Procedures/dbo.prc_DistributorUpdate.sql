SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_DistributorUpdate]
(
	@DistributorID int,
	@Name nvarchar(500),
	@CustomerID int = NULL,
	@PipePassSiteID int = NULL,
	@DistributorTypeID smallint,
	@CreatedBy nvarchar(50),
	@CreateDate datetime
)
AS
	SET NOCOUNT ON
	
	UPDATE [Distributor]
	SET
		[DistributorID] = @DistributorID,
		[Name] = @Name,
		[CustomerID] = @CustomerID,
		[PipePassSiteID] = @PipePassSiteID,
		[DistributorTypeID] = @DistributorTypeID,
		[CreatedBy] = @CreatedBy,
		[CreateDate] = @CreateDate
	WHERE 
		[DistributorID] = @DistributorID

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_DistributorUpdate] TO [PolicyEXDBReader]
GO
