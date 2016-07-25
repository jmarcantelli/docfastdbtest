SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[prc_rpt_GetFaceToFaceUsageBySupplier]

(
	@SupplierID	Int
)
AS
BEGIN
	Select	[Supplier] = si.Description,
			[Distributor] = Case d.DistributorTypeID When 1 Then d.Name When 2 Then d.Name When 3 Then si.Description End,
			[Agent] = u.FirstName + ' ' + u.LastName,
			[Agent Email] = u.EmailAddress,
			[No Of Policies Signed Face to Face] = Count(*)
	From	ConsumerRecipient cr (NoLock)
			Inner Join Policy p (NoLock) on p.PolicyID = cr.PolicyID
			Inner Join PolicyUser pu (NoLock) on pu.PolicyID = p.PolicyID
			Inner Join [User] u (Nolock) on u.UserID = pu.UserID and u.UserTypeID = 6
			Inner Join SupplierIdentifier si (Nolock) on si.SupplierID = p.SupplierID
			Inner Join Distributor d (Nolock) on d.DistributorID = u.DistributorID
	Where	cr.FaceToFace = 1 and p.SupplierID = @SupplierID
	Group By si.Description, d.DistributorTypeID, d.Name, u.FirstName + ' ' + u.LastName, u.EmailAddress
	Order By Count(*) Desc, d.Name
END
GO
GRANT EXECUTE ON  [dbo].[prc_rpt_GetFaceToFaceUsageBySupplier] TO [PolicyEXDBReader]
GO
