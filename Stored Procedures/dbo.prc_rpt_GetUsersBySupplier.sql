SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[prc_rpt_GetUsersBySupplier]

(
	@SupplierID		Int
)
AS
BEGIN
	Select	Distinct [Login Name] = COALESCE(u.LoginName, ''),
			[First Name] = u.FirstName,
			[Last Name] = u.LastName,
			[Email Address] = u.EmailAddress,
			[User Type] = ut.UserTypeName,
			[Identifying Value] = Coalesce(sui.IdentifyingValue, ''),
			[Effective Date] = u.EffectiveDate,
			[Expiry Date] = IsNull(u.ExpirationDate, '12/31/9999'),
			[Mapping] = COALESCE((SELECT STUFF((SELECT ', ' + si.Description + ': ' + sui.IdentifyingValue
									FROM	SupplierUserIdentifier sui
											Inner Join SupplierIdentifier si on si.SupplierID = sui.SupplierID
									Where	sui.UserID = u.UserID
									FOR XML PATH('')) ,1,2,'')), '')
	from	[User] u 
			inner join UserType ut on ut.UserTypeID = u.UserTypeID
			Left Outer Join SupplierUserIdentifier sui on sui.UserID = u.UserID
	Where	u.SupplierID = @SupplierID
	Order By [First Name], [Last Name], [Email Address]
END
GO
GRANT EXECUTE ON  [dbo].[prc_rpt_GetUsersBySupplier] TO [PolicyEXDBReader]
GO
