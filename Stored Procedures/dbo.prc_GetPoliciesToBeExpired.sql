SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_GetPoliciesToBeExpired]  
(  
    @SupplierID int,
	@DateBasedOnSupplierTimeZone Varchar(10)
)  
AS  
Begin
	Declare	@PolicyRoleId_Approver	SmallInt
	Declare	@UserTypeId_CCM		Int
	Declare	@UserTypeId_CCMA	Int
	Declare	@ExpireIncompletePolicyPastDeliveryDate		Varchar(100)
	Declare	@InitiatingUserId	Int

	Select	@InitiatingUserId = UserId
	From	[User]
	Where	Lower(LTRIM(RTRIM(LoginName))) = 'donotreply@ipipeline.com'

	Select	@ExpireIncompletePolicyPastDeliveryDate = Lower(LTRIM(RTRIM(COALESCE(ConfigurationValue, 'false'))))
	From	SupplierConfigurations sc (Nolock)
	Where	SupplierID = @SupplierID and ConfigurationKey = 'ExpireIncompletePolicyPastDeliveryDate'

	If @ExpireIncompletePolicyPastDeliveryDate = 'true'
	Begin
		Select	p.PolicyID, InitiatingUserId = @InitiatingUserId
		From	Policy p (Nolock)
		Where	p.SupplierID = @SupplierID
				and DATEDIFF(dd, DATEADD(day,1,p.DeliveryDate), @DateBasedOnSupplierTimeZone) <= 0
				and p.PolicyStatusID in (
						2,	--Pending Delivery
						3,	--Sent to Distributor
						4,	--Sent to Agent
						5,	--Sent to Consumer
						6,	--Received by Distributor
						7,	--Received by Agent
						8,	--Received by Consumer
						16,	--Declined Offer by Distributor (NTO)
						17,	--Declined Offer by Agent (NTO)
						19	--Declined Offer Forwarded by Agent (NTO)
					)
	End
End

GO
GRANT EXECUTE ON  [dbo].[prc_GetPoliciesToBeExpired] TO [PolicyEXDBReader]
GO
