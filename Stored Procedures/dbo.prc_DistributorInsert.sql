SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_DistributorInsert]
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

	INSERT INTO [Distributor]
	(
		[DistributorID],
		[Name],
		[CustomerID],
		[PipePassSiteID],
		[DistributorTypeID],
		[CreatedBy],
		[CreateDate]
	)
	VALUES
	(
		@DistributorID,
		@Name,
		@CustomerID,
		@PipePassSiteID,
		@DistributorTypeID,
		@CreatedBy,
		@CreateDate
	)

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_DistributorInsert] TO [PolicyEXDBReader]
GO
