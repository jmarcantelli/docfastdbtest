SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[prc_rpt_GetPolicyApproverList]
(
	@PolNumber		Varchar(250),
	@SupplierID		Int
)
AS
BEGIN
	Select	'' as LoginName, Coalesce(c.FirstName + ' ' + c.LastName, '') as [User Name], Coalesce(c.EmailAddress, ''), UserTypeName = 'Consumer', PolicyRoleName = '', '' as Distributor
	From	[ConsumerRecipient] c
			Inner Join Policy p on p.PolicyID = c.PolicyID
	Where	p.PolNumber = @PolNumber and
			p.SupplierID = @SupplierID
	Union
	Select	LoginName = COALESCE(u.LoginName, ''), u.FirstName + ' ' + u.LastName as [User Name], u.EmailAddress, ut.UserTypeName, pr.PolicyRoleName, d.Name as Distributor
	From	[User] u
			Inner Join PolicyUser pu on pu.UserID = u.UserID
			Inner Join PolicyRole pr on pr.PolicyRoleID = pu.PolicyRoleID
			Inner Join UserType ut on ut.UserTypeID = u.UserTypeID
			Inner Join Policy p on p.PolicyID = pu.PolicyID
			Left Outer Join Distributor d on d.DistributorID = u.DistributorID
	Where	p.PolNumber = @PolNumber and
			p.SupplierID = @SupplierID
END
GO
GRANT EXECUTE ON  [dbo].[prc_rpt_GetPolicyApproverList] TO [PolicyEXDBReader]
GO
