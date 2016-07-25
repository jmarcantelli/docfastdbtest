SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[prc_rpt_GetSupplierDistributorMapping]

(
	@SupplierID		Int
)
AS
BEGIN
	Select	d.DistributorID, Name = d.Name, [Type] = dt.Description, [GAID] = d.CustomerID, [Identifying Value] = sdi.IdentifyingValue,
			[SSO Client] = COALESCE(ConfigurationValue, 'false')
	From	SupplierDistributorIdentifier sdi (NoLock)
			Inner Join Distributor d (NoLock) on d.DistributorID = sdi.DistributorID
			Inner Join DistributorType dt (NoLock) on dt.DistributorTypeID = d.DistributorTypeID
			Left Outer Join DistributorConfigurations dc1 (Nolock) on dc1.DistributorID = d.DistributorID and ConfigurationKey = 'UseSingleSignOn'
	Where	sdi.SupplierID = @SupplierID
	Order By d.Name
END
GO
GRANT EXECUTE ON  [dbo].[prc_rpt_GetSupplierDistributorMapping] TO [PolicyEXDBReader]
GO
