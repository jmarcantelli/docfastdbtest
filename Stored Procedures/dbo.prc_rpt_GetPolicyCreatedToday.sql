SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[prc_rpt_GetPolicyCreatedToday]
(
	@SupplierID		Int
)
AS
BEGIN
	Select	[Policy Number] = p.PolNumber, 
			[Delivery Type] = pdt.DeliveryTypeCode,
			[Policy Status] = ps.PolicyStatusName,
			Supplier = Coalesce(si.SupplierName, si.Description, ''),
			[Distributor] = Coalesce(d.Name, 'Not Applicable')
	From	[Policy] p
			Inner Join SupplierIdentifier si (Nolock) on si.SupplierID = p.SupplierID
			Inner Join PolicyDeliveryType pdt (Nolock) on pdt.PolicyDeliveryTypeID = p.PolicyDeliveryTypeID
			Inner Join PolicyStatus ps (Nolock) on ps.PolicyStatusID = p.PolicyStatusID
			Left Outer Join PolicyDistributor pd (Nolock) on pd.PolicyID = p.PolicyID
			Left Outer Join Distributor d (Nolock) on d.DistributorID = pd.DistributorID
	Where	p.SupplierID = @SupplierID
			and Convert(Varchar(10), p.CreateDate, 101) = Convert(Varchar(10), GetDate(), 101)
END
GO
GRANT EXECUTE ON  [dbo].[prc_rpt_GetPolicyCreatedToday] TO [PolicyEXDBReader]
GO
