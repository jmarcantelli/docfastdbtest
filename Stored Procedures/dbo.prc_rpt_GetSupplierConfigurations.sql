SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[prc_rpt_GetSupplierConfigurations]

(
	@SupplierID		Int
)
AS
BEGIN
	declare	@DefaultCaseManagerUserID	varchar(200)
	Select	@DefaultCaseManagerUserID = ConfigurationValue From SupplierConfigurations Where ConfigurationKey = 'DefaultCaseManagerUserID' and SupplierID = @SupplierID
	declare	@DefaultCaseManager	varchar(2000)

	Select	@DefaultCaseManager = ''
	If @DefaultCaseManagerUserID Is Not null and @DefaultCaseManagerUserID <> ''
	Begin
		Select	@DefaultCaseManager = @DefaultCaseManagerUserID + ' [' + FirstName + ' ' + LastName + ', ' + EmailAddress  + ']' From [User] (NoLock) Where UserID = @DefaultCaseManagerUserID
	End

	Select	[Key] = sc.ConfigurationKey,
			[Value] = Case sc.ConfigurationKey When 'DefaultCaseManagerUserID' Then @DefaultCaseManager Else sc.ConfigurationValue end,
			[Package Type] = COALESCE(pt.PackageTypeName, ''),
			[Description] = Coalesce(sc.Description, '')
	From	SupplierConfigurations sc (NoLock)
			Left Outer Join PackageType pt (Nolock) on pt.PackageTypeID = sc.PackageTypeID
	Where	sc.SupplierID = @SupplierID
			and sc.ConfigurationKey Not In ('DocuSignAPIUserName', 'DocuSignPassword', 'DocuSignAPIUserName_Preview', 'DocuSignPassword_Preview')
	Order By sc.ConfigurationKey
END
GO
GRANT EXECUTE ON  [dbo].[prc_rpt_GetSupplierConfigurations] TO [PolicyEXDBReader]
GO
