SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[prc_rpt_GetLoginsByEmailAddress]
(
	@EmailAddress	nvarchar(1000)
)
AS
BEGIN
	Select	@EmailAddress = Lower(LTRIM(RTRIM(@EmailAddress)))

	Select	Distinct [Login Name] = COALESCE(u.LoginName, ''),
			[First Name] = u.FirstName,
			[Last Name] = u.LastName,
			[Email Address] = u.EmailAddress,
			[User Type] = Case Convert(Varchar, d.DistributorTypeID) + ut.UserTypeName
								When '1Agent' Then 'Distributor Agent'
								When '2Agent' Then 'Direct Writer Agent'
								When '3Agent' Then 'Career Agent'
								Else ut.UserTypeName
						   End,
			[Distributor] = Case	ISNull(d.Name, '')
								When '' Then ''
								When 'Not Applicable' Then ''
								Else d.Name
							End,
			Supplier = Coalesce(si.SupplierName, si.Description, ''),
			[Identifying Value] = Coalesce(sui.IdentifyingValue, '')
	from	[User] u 
			inner join UserType ut on ut.UserTypeID = u.UserTypeID
			inner join Distributor d on d.DistributorID = u.DistributorID
			Left Outer Join SupplierIdentifier si on si.SupplierID = u.SupplierID
			Left Outer Join SupplierUserIdentifier sui on sui.UserID = u.UserID
	Where	Lower(u.EmailAddress) = @EmailAddress
	Order By Coalesce(si.SupplierName, si.Description, '')
END
GO
GRANT EXECUTE ON  [dbo].[prc_rpt_GetLoginsByEmailAddress] TO [PolicyEXDBReader]
GO
