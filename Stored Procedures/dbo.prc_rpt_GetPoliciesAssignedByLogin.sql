SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[prc_rpt_GetPoliciesAssignedByLogin]
(
	@LoginName	nvarchar(400)
)
AS
BEGIN
	Declare	@UserID	Int
	Select	@UserID = UserID From [User] Where LoginName = @LoginName

	Select	[Policy Number] = P.PolNumber,
			[Supplier] = Coalesce(si.SupplierName, si.Description, ''),
			[Created Date] = p.CreateDate,
			[Status] = PolicyStatusName,
			Distributor = Coalesce(d.Name, ''),
			Workflow = pdt.DeliveryTypeCode
	From	Policy p (NoLock)
			Inner Join SupplierIdentifier si (NoLock) on si.SupplierID = p.SupplierID
			Inner Join PolicyUser pu (NoLock) on pu.PolicyID = p.PolicyID
			Inner  join PolicyStatus ps (NoLock) on ps.PolicyStatusID = p.PolicyStatusID
			Inner Join PolicyDeliveryType pdt (NoLock) on pdt.PolicyDeliveryTypeID = p.PolicyDeliveryTypeID
			Left Outer Join PolicyDistributor pd (NoLock) on pd.PolicyID = p.PolicyID
			Left Outer Join Distributor d (NoLock) on d.DistributorID = pd.DistributorID
	Where	pu.UserID = @UserID Order By Coalesce(si.SupplierName, si.Description, ''), PolicyStatusName, p.CreateDate
END
GO
GRANT EXECUTE ON  [dbo].[prc_rpt_GetPoliciesAssignedByLogin] TO [PolicyEXDBReader]
GO
