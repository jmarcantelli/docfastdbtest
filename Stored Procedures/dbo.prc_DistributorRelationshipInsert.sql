SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_DistributorRelationshipInsert]
(
	@ParentDistributorID int,
	@ChildDistributorID int,
	@CreatedBy nvarchar(50),
	@CreateDate datetime
)
AS
	SET NOCOUNT ON

	INSERT INTO [DistributorRelationship]
	(
		[ParentDistributorID],
		[ChildDistributorID],
		[CreatedBy],
		[CreateDate]
	)
	VALUES
	(
		@ParentDistributorID,
		@ChildDistributorID,
		@CreatedBy,
		@CreateDate
	)

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_DistributorRelationshipInsert] TO [PolicyEXDBReader]
GO
