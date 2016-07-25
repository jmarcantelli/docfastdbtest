SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_DistributorRelationshipDelete]
(
	@ParentDistributorID int,
	@ChildDistributorID int
)
AS
	SET NOCOUNT ON

	DELETE 
	FROM   [DistributorRelationship]
	WHERE  
		[ParentDistributorID] = @ParentDistributorID AND
		[ChildDistributorID] = @ChildDistributorID

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_DistributorRelationshipDelete] TO [PolicyEXDBReader]
GO
