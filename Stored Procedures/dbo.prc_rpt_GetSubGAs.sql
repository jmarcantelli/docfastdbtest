SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[prc_rpt_GetSubGAs]

(
	@SupplierID	Int
)
AS
BEGIN
		Select	[Mapped Distributor] = d1.Name,
				[SubGA] = d2.Name
		From	SupplierDistributorIdentifier sdi (Nolock)
				Inner Join DistributorRelationship dr (Nolock) on dr.ParentDistributorID = sdi.DistributorID
				Inner Join Distributor d1 (Nolock) on d1.DistributorID = dr.ParentDistributorID
				Inner Join Distributor d2 (Nolock) on d2.DistributorID = dr.ChildDistributorID
		Where	sdi.SupplierID = @SupplierID
		Order By d1.Name, d2.Name
END
GO
GRANT EXECUTE ON  [dbo].[prc_rpt_GetSubGAs] TO [PolicyEXDBReader]
GO
