SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[RPT_GetAllPoliciesElapsedTimeBySupplierId]
(
	@SupplierID		Int,
	@StartDate	DateTime,
	@EndDate DateTime
)
AS
BEGIN
SELECT DISTINCT s.SupplierName AS Carrier,
                           p.PolNumber AS [Policy Number],
                           COALESCE(pt.ProductTypeName,'') AS [Product Type],
                           [Create Date] = p.CreateDate,
                           [Status Date] = pah.ActivityDate,
                           ps.PolicyStatusName AS [Policy Status],
                           [Elapsed Time] = Convert(Varchar, DateDiff(dd, p.CreateDate, pah.ActivityDate)) + ' days ' 
                                            + Convert(Varchar, DateDiff(hh, p.CreateDate, pah.ActivityDate) % 24) + ' hours '
                                            + Convert(Varchar, DateDiff(mi, p.CreateDate, pah.ActivityDate) % 60) + ' mins'                                                                
FROM dbo.policy p (NOLOCK)
INNER JOIN  dbo.SupplierIdentifier s (NOLOCK) ON s.SupplierID=p.SupplierID
LEFT OUTER JOIN dbo.ProductType pt (NOLOCK) ON pt.ProductTypeID=p.ProductTypeID
INNER JOIN PolicyStatus ps (NOLOCK) ON p.PolicyStatusID=ps.PolicyStatusID
Inner Join (SELECT   pah.PolicyID, 
                     ActivityDate = Max(pah.ActivityDate)
                     FROM   PolicyActivityHistory pah (NOLOCK)
                            Inner Join Policy p (Nolock) on p.PolicyID = pah.PolicyID
                     WHERE  pah.NewPolicyStatusID = p.PolicyStatusID and 
                            COALESCE(pah.PreviousPolicyStatusID, 0) <> pah.NewPolicyStatusID and
                            SupplierID = @SupplierID Group By pah.PolicyID) pah on pah.PolicyID = p.PolicyID 
Where  p.SupplierID = @SupplierID
AND p.CreateDate>=@StartDate
AND p.CreateDate <= @EndDate
order by p.CreateDate
END
GO
GRANT EXECUTE ON  [dbo].[RPT_GetAllPoliciesElapsedTimeBySupplierId] TO [PolicyEXDBReader]
GO
