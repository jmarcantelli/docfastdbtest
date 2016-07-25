SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[RPT_GetAllPoliciesCountByInProcessCompletePrintForDirectWriters]
(
	@SupplierID		Int,
	@StartDate	DateTime,
	@EndDate DateTime
)
AS
BEGIN
Select	d.Name,
[In Process] = COALESCE(pc3.[Policy Count], 0),
		convert(varchar(10),coalesce(convert(decimal(5,1),(((COALESCE(pc3.[Policy Count], 0))*100.0)/nullif(SUM(pc3.[Policy Count] )over (),0))),0))+'%' as Percentage
		, Completed = COALESCE(pc1.[Policy Count], 0),
		convert(varchar(10),coalesce(convert(decimal(5,1),(((COALESCE(pc1.[Policy Count], 0))*100.0)/nullif(SUM(pc1.[Policy Count] )over (),0))),0))+'%' as Percentage
		, Printed = COALESCE(pc2.[Policy Count], 0),
		convert(varchar(10),coalesce(convert(decimal(5,1),(((COALESCE(pc2.[Policy Count], 0))*100.0)/nullif(SUM(pc2.[Policy Count] )over (),0))),0))+'%' as Percentage
		
From	SupplierDistributorIdentifier sdi (Nolock) 
		Inner Join Distributor d on d.DistributorID = sdi.DistributorID
		Left Outer Join (
							Select	pd1.DistributorID, [Policy Count] = Count(*)
							From	Policy p1 (Nolock)
									Inner Join PolicyDistributor pd1 (Nolock) on pd1.PolicyID = p1.PolicyID
							Where	p1.SupplierID = @SupplierID and p1.PolicyStatusID = 24
		AND p1.CreateDate >= @StartDate
		AND p1.CreateDate <= @EndDate
							Group By pd1.DistributorID	
						 ) pc1 on sdi.DistributorID = pc1.DistributorID
		Left Outer Join (
							Select	pd2.DistributorID, [Policy Count] = Count(*)
							From	Policy p2 (Nolock)
									Inner Join PolicyDistributor pd2 (Nolock) on pd2.PolicyID = p2.PolicyID
							Where	p2.SupplierID = @SupplierID and p2.PolicyStatusID in (21, 22, 23, 27)
		AND p2.CreateDate >= @StartDate
		AND p2.CreateDate <= @EndDate
							Group By pd2.DistributorID	
						) pc2 on sdi.DistributorID = pc2.DistributorID
		Left Outer Join (
							Select	pd3.DistributorID, [Policy Count] = Count(*)
							From	Policy p3 (Nolock)
									Inner Join PolicyDistributor pd3 (Nolock) on pd3.PolicyID = p3.PolicyID
							Where	p3.SupplierID = @SupplierID and p3.PolicyStatusID Not in (24, 21, 22, 23, 27,25,1,2)
		AND p3.CreateDate >= @StartDate
		AND p3.CreateDate <= @EndDate
							Group By pd3.DistributorID	
						) pc3 on sdi.DistributorID = pc3.DistributorID
Where	sdi.SupplierID = @SupplierID
		and d.DistributorTypeID =2
		group by d.Name,pc1.[Policy Count] ,pc2.[Policy Count],pc3.[Policy Count]

Order By d.Name
END
GO
GRANT EXECUTE ON  [dbo].[RPT_GetAllPoliciesCountByInProcessCompletePrintForDirectWriters] TO [PolicyEXDBReader]
GO
