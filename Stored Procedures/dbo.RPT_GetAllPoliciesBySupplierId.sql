SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[RPT_GetAllPoliciesBySupplierId]
(
	@SupplierID		Int,
	@StartDate	DateTime,
	@EndDate DateTime
)
AS
BEGIN
SELECT DISTINCT p.PolNumber AS [Policy Number],
				p.ConsumerName AS [Consumer Name],
				s.SupplierName AS [Carrier],
				[Carrier Case Manager] = COALESCE((SELECT u.FirstName + ' ' + u.LastName 
                           FROM   [User] u (NOLOCK)
                                         INNER JOIN PolicyUser pu ON pu.UserID = u.UserID
                                         INNER JOIN PolicyRole pr ON pr.PolicyRoleID = pu.PolicyRoleID
                           WHERE  pu.PolicyID = p.PolicyID and u.UserTypeID IN (2, 3) AND pr.PolicyRoleID IN (1, 3, 4)), ''),
				[Distributor] = COALESCE((SELECT u.FirstName + ' ' + u.LastName 
                           FROM   [User] u (NOLOCK)
                                         INNER JOIN PolicyUser pu ON pu.UserID = u.UserID
                                         INNER JOIN PolicyRole pr ON pr.PolicyRoleID = pu.PolicyRoleID
                           WHERE  pu.PolicyID = p.PolicyID and u.UserTypeID IN (4, 5) AND pr.PolicyRoleID IN (1, 3, 4)), ''),
				[Agent] = COALESCE((SELECT u.FirstName + ' ' + u.LastName 
                           FROM   [User] u (NOLOCK)
                                         INNER JOIN PolicyUser pu ON pu.UserID = u.UserID
                                         INNER JOIN PolicyRole pr ON pr.PolicyRoleID = pu.PolicyRoleID
                           WHERE  pu.PolicyID = p.PolicyID and u.UserTypeID = 6 AND pr.PolicyRoleID IN (1, 3, 4)), ''),
				[Payer]=COALESCE((SELECT cr.FirstName + ' ' + cr.LastName 
                           FROM   ConsumerRecipient cr (NOLOCK)
						   WHERE cr.PolicyID=p.PolicyID  AND cr.relationroleCodeId =3),''),
				COALESCE(pt.ProductTypeName,'') AS [Product Type],
				pdt.Description AS [Workflow],
				ps.PolicyStatusName AS [Policy Status], 
				[Status Date] = COALESCE((SELECT Max(pah.ActivityDate) FROM PolicyActivityHistory pah (NOLOCK) WHERE pah.NewPolicyStatusID=p.PolicyStatusID 
							AND p.PolicyID=pah.PolicyID 
							AND ISNULL(pah.PreviousPolicyStatusID,0) !=pah.NewPolicyStatusID), '')                                        
FROM dbo.policy p (NOLOCK)
INNER JOIN  dbo.SupplierIdentifier s (NOLOCK) ON s.SupplierID=p.SupplierID
LEFT OUTER JOIN dbo.ProductType pt (NOLOCK) ON pt.ProductTypeID=p.ProductTypeID
INNER JOIN PolicyStatus ps (NOLOCK) ON p.PolicyStatusID=ps.PolicyStatusID
INNER JOIN PolicyDeliveryType pdt (NOLOCK) ON pdt.PolicyDeliveryTypeID=p.PolicyDeliveryTypeID
Where  p.SupplierID = @SupplierID
AND p.CreateDate >= @StartDate
AND p.CreateDate <= @EndDate
END
GO
GRANT EXECUTE ON  [dbo].[RPT_GetAllPoliciesBySupplierId] TO [PolicyEXDBReader]
GO
