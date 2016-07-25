SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_DistributorRelationshipUpdate]
(
	@ParentDistributorID int,
	@ChildDistributorID int,
	@CreatedBy nvarchar(50),
	@CreateDate datetime
)
AS
	SET NOCOUNT ON
	
	UPDATE [DistributorRelationship]
	SET
		[ParentDistributorID] = @ParentDistributorID,
		[ChildDistributorID] = @ChildDistributorID,
		[CreatedBy] = @CreatedBy,
		[CreateDate] = @CreateDate
	WHERE 
		[ParentDistributorID] = @ParentDistributorID AND
		[ChildDistributorID] = @ChildDistributorID

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_DistributorRelationshipUpdate] TO [PolicyEXDBReader]
GO
