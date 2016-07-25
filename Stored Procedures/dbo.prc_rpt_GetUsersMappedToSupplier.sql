SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[prc_rpt_GetUsersMappedToSupplier]

(
	@SupplierID		Int
)
AS
BEGIN
	Select	[Login Name] = Coalesce(u.LoginName, ''),
			[First name] = u.FirstName,
			[Last Name] = u.LastName,
			[Email] = u.EmailAddress,
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
							End
			,sui.IdentifyingValue as 'User Code'
	from	[User] u 
			inner join UserType ut (Nolock) on ut.UserTypeID = u.UserTypeID
			inner join Distributor d (Nolock) on d.DistributorID = u.DistributorID
			Inner join SupplierUserIdentifier sui (Nolock) on sui.UserID = u.UserID and sui.SupplierID = @SupplierID
			Inner Join SupplierDistributorIdentifier sdi (Nolock) on sdi.DistributorID = u.DistributorID
	Where	u.SupplierID = @SupplierID
	Union
	Select	[Login Name] = Coalesce(u.LoginName, ''),
			[First name] = u.FirstName,
			[Last Name] = u.LastName,
			[Email] = u.EmailAddress,
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
							End
			,sui.IdentifyingValue as 'User Code'
	from	SupplierDistributorIdentifier sdi (Nolock) 
			Inner Join [User] u (Nolock) on u.DistributorID = sdi.DistributorID
			inner join UserType ut (Nolock) on ut.UserTypeID = u.UserTypeID
			Inner join Distributor d (Nolock) on d.DistributorID = u.DistributorID
			Inner join SupplierUserIdentifier sui (Nolock) on sui.UserID = u.UserID and sui.SupplierID = @SupplierID
	Where	sdi.SupplierID = @SupplierID
	Order By Case	ISNull(d.Name, '')
				When '' Then ''
				When 'Not Applicable' Then ''
				Else d.Name
			End,
			Case Convert(Varchar, d.DistributorTypeID) + ut.UserTypeName
				When '1Agent' Then 'Distributor Agent'
				When '2Agent' Then 'Direct Writer Agent'
				When '3Agent' Then 'Career Agent'
				Else ut.UserTypeName
			End,
			u.FirstName,
			u.LastName,
			u.EmailAddress
END
GO
GRANT EXECUTE ON  [dbo].[prc_rpt_GetUsersMappedToSupplier] TO [PolicyEXDBReader]
GO
