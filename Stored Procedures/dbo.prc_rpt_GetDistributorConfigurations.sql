SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[prc_rpt_GetDistributorConfigurations]

(
	@DistributorID		Int
)
AS
BEGIN
	declare	@DefaultCaseManagerUserID	varchar(200)
	Select	@DefaultCaseManagerUserID = ConfigurationValue From DistributorConfigurations Where ConfigurationKey = 'DefaultCaseManagerUserID' and DistributorID = @DistributorID
	declare	@DefaultCaseManager	varchar(2000)

	Select	@DefaultCaseManager = ''
	If @DefaultCaseManagerUserID Is Not null and @DefaultCaseManagerUserID <> ''
	Begin
		Select	@DefaultCaseManager = @DefaultCaseManagerUserID + ' [' + FirstName + ' ' + LastName + ', ' + EmailAddress  + ']' From [User] (NoLock) Where UserID = @DefaultCaseManagerUserID
	End

	Select	[Key] = sc.ConfigurationKey, 
			[Value] = Case sc.ConfigurationKey When 'DefaultCaseManagerUserID' Then @DefaultCaseManager Else sc.ConfigurationValue end
	From	DistributorConfigurations sc (NoLock)
	Where	sc.DistributorID = @DistributorID
			and sc.ConfigurationKey Not In ('DocuSignAPIUserName', 'DocuSignPassword')
	Order By sc.ConfigurationKey
END
GO
GRANT EXECUTE ON  [dbo].[prc_rpt_GetDistributorConfigurations] TO [PolicyEXDBReader]
GO
