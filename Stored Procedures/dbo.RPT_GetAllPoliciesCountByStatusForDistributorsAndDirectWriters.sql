SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[RPT_GetAllPoliciesCountByStatusForDistributorsAndDirectWriters]
(
	@SupplierID		Int,
	@StartDate	DateTime,
	@EndDate DateTime
)
AS
BEGIN
Select	d.Name,
[In Process] = COALESCE(pc3.[Policy Count], 0),
		convert(varchar(10),coalesce(convert(decimal(5,1),(((COALESCE(pc3.[Policy Count], 0))*100.0)/nullif(SUM(pc3.[Policy Count] )over (),0))),0))+'%' as [In Process Pct],
		[Completed] = COALESCE(pc1.[Policy Count], 0),
		convert(varchar(10),coalesce(convert(decimal(5,1),(((COALESCE(pc1.[Policy Count], 0))*100.0)/nullif(SUM(pc1.[Policy Count] )over (),0))),0))+'%' as [Completed Pct],
		[Printed] = COALESCE(pc2.[Policy Count], 0),
		convert(varchar(10),coalesce(convert(decimal(5,1),(((COALESCE(pc2.[Policy Count], 0))*100.0)/nullif(SUM(pc2.[Policy Count] )over (),0))),0))+'%' as [Printed Pct],
		[Declined]=coalesce(pc4.[Policy Count],0),
		convert(varchar(10),coalesce(convert(decimal(5,1),(((COALESCE(pc4.[Policy Count], 0))*100.0)/nullif(SUM(pc4.[Policy Count] )over (),0))),0))+'%' as [Declined Pct],
		[Reissue Requested]=coalesce(pc5.[Policy count],0),
		convert(varchar(10),coalesce(convert(decimal(5,1),(((COALESCE(pc5.[Policy Count], 0))*100.0)/nullif(SUM(pc5.[Policy Count] )over (),0))),0))+'%' as [Reissue Request Pct],
		[Expired]=coalesce(pc6.[policy count],0),
		convert(varchar(10),coalesce(convert(decimal(5,1),(((COALESCE(pc6.[Policy Count], 0))*100.0)/nullif(SUM(pc6.[Policy Count] )over (),0))),0))+'%' as [Expired Pct],
		[Failed User]=coalesce(pc8.[Policy Count],0),
		convert(varchar(10),coalesce(convert(decimal(5,1),(((COALESCE(pc8.[Policy Count], 0))*100.0)/nullif(SUM(pc8.[Policy Count] )over (),0))),0))+'%' as [Failed User Pct],
		[Total]=coalesce(pc7.[policy count],0),
		convert(varchar(10),coalesce(convert(decimal(5,1),(((COALESCE(pc7.[Policy Count], 0))*100.0)/nullif(SUM(pc7.[Policy Count] )over (),0))),0))+'%' as [Total Pct]
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
							Where	p3.SupplierID = @SupplierID and p3.PolicyStatusID in (3,4,5,6,7,8)
		AND p3.CreateDate >= @StartDate
		AND p3.CreateDate <= @EndDate
							Group By pd3.DistributorID	
						) pc3 on sdi.DistributorID = pc3.DistributorID
		Left Outer Join (
							Select	pd4.DistributorID, [Policy Count] = Count(*)
							From	Policy p4 (Nolock)
									Inner Join PolicyDistributor pd4 (Nolock) on pd4.PolicyID = p4.PolicyID
							Where	p4.SupplierID = @SupplierID and p4.PolicyStatusID in (15,16,17,18,19,20)
		AND p4.CreateDate >= @StartDate
		AND p4.CreateDate <= @EndDate
							Group By pd4.DistributorID	
						) pc4 on sdi.DistributorID = pc4.DistributorID
		Left Outer Join (
							Select	pd5.DistributorID, [Policy Count] = Count(*)
							From	Policy p5 (Nolock)
									Inner Join PolicyDistributor pd5 (Nolock) on pd5.PolicyID = p5.PolicyID
							Where	p5.SupplierID = @SupplierID and p5.PolicyStatusID =31
		AND p5.CreateDate >= @StartDate
		AND p5.CreateDate <= @EndDate
							Group By pd5.DistributorID	
						) pc5 on sdi.DistributorID = pc5.DistributorID
		Left Outer Join (
							Select	pd6.DistributorID, [Policy Count] = Count(*)
							From	Policy p6 (Nolock)
									Inner Join PolicyDistributor pd6 (Nolock) on pd6.PolicyID = p6.PolicyID
							Where	p6.SupplierID = @SupplierID and p6.PolicyStatusID =32
		AND p6.CreateDate >= @StartDate
		AND p6.CreateDate <= @EndDate
							Group By pd6.DistributorID	
						) pc6 on sdi.DistributorID = pc6.DistributorID
		Left Outer Join (
							Select	pd7.DistributorID, [Policy Count] = Count(*)
							From	Policy p7 (Nolock)
									Inner Join PolicyDistributor pd7 (Nolock) on pd7.PolicyID = p7.PolicyID
							Where	p7.SupplierID = @SupplierID
		AND p7.CreateDate >= @StartDate
		AND p7.CreateDate <= @EndDate
							Group By pd7.DistributorID	
						) pc7 on sdi.DistributorID = pc7.DistributorID
		Left Outer Join (
							Select	pd8.DistributorID, [Policy Count] = Count(*)
							From	Policy p8 (Nolock)
									Inner Join PolicyDistributor pd8 (Nolock) on pd8.PolicyID = p8.PolicyID
							Where	p8.SupplierID = @SupplierID and p8.PolicyStatusID in (29,30)
		AND p8.CreateDate >= @StartDate
		AND p8.CreateDate <= @EndDate
							Group By pd8.DistributorID	
						) pc8 on sdi.DistributorID = pc8.DistributorID
Where	sdi.SupplierID = @SupplierID
		and d.DistributorTypeID in (1,2)
		group by d.Name,pc1.[Policy Count] ,pc2.[Policy Count],pc3.[Policy Count],pc4.[Policy Count],pc5.[Policy Count],pc6.[Policy Count],pc7.[Policy Count],pc8.[Policy Count]

Order By d.Name
END
GO
GRANT EXECUTE ON  [dbo].[RPT_GetAllPoliciesCountByStatusForDistributorsAndDirectWriters] TO [PolicyEXDBReader]
GO
