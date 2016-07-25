SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[RPT_GetPolicyCountByStatusBySupplierId_TimeRange]
(
	@SupplierID		Int,
	@StartDate	DateTime,
	@EndDate DateTime
)
AS
BEGIN
	Declare	@TotalPolicyCount	BigInt
	Select	@TotalPolicyCount = Count(*) from policy p where p.SupplierID=@SupplierID AND  p.CreateDate >= @StartDate AND CreateDate <= @EndDate

	select 
			[Supplier Name]=COALESCE(si.SupplierName,''),
			[Status]= result.Status,
			[Policy Count],
			convert(varchar(10),coalesce(convert(decimal(5,2),((([Policy Count])*100.0)/@TotalPolicyCount)),0))+'%' as Percentage
	from	(	
				Select	SupplierId, 
						ps.PolicyStatusName as [Status], 
						Count(*) as [Policy Count]
				From	Policy p (NOLOCK)
						Inner Join PolicyStatus ps (NOLOCK) on ps.PolicyStatusID = p.PolicyStatusID
				Where	SupplierID = @SupplierID
						AND p.CreateDate >= @StartDate
						AND p.CreateDate <= @EndDate
				Group By SupplierId, ps.PolicyStatusName
				UNION
				select	NULL,
						'Total' as [Status],
						@TotalPolicyCount as [Policy Count] 
			)result
	LEFT OUTER join SupplierIdentifier si (NOLOCK) on si.SupplierID=result.SupplierID
	Order By coalesce(si.SupplierName, si.Description, 'ZZZZZ'), [Status] asc
END
GO
GRANT EXECUTE ON  [dbo].[RPT_GetPolicyCountByStatusBySupplierId_TimeRange] TO [PolicyEXDBReader]
GO
