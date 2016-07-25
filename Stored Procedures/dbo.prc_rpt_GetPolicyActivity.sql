SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[prc_rpt_GetPolicyActivity]
(
	@PolNumber		Varchar(250),
	@SupplierID		Int
)
AS
BEGIN
	Select	[Activity Date] = DateAdd(hour, -5, pah.ActivityDate)
			, [Status] = Coalesce(ps.PolicyStatusName, '')
			, [User Type] = Coalesce(ut.UserTypeName, '')
			, Consumer = Coalesce(cr.FirstName + ' ' + cr.LastName, '')
			, a.Action, pahd.Activity
			, Browser = Coalesce(pah.BrowserName + ' ' + pah.BrowserVersion, '')
			, [Language] = Coalesce(l.Name, '')
			, [Platform] = Coalesce(pah.BrowserPlatform, ''),
			[Created By] = Coalesce(pah.CreatedBy, '')
	From	PolicyActivityHistory pah (Nolock)
			Inner Join PolicyActivityHistoryDetail pahd (Nolock) on pahd.PolicyActivityHistoryID = pah.PolicyActivityHistoryID
			Left Outer Join PolicyStatus ps (Nolock) on ps.PolicyStatusID = pah.NewPolicyStatusID
			Left Outer Join [Action] a (Nolock) on a.ActionID = pah.ActionID
			Left Outer Join [User] u (Nolock) on u.UserID = pah.UserID
			Left Outer Join [ConsumerRecipient] cr (Nolock) on cr.ConsumerRecipientID = pah.ConsumerRecipientID
			Left Outer Join UserType ut (Nolock) on ut.UserTypeID = u.UserTypeID
			Inner Join Policy p (Nolock) on p.PolicyID = pah.PolicyID
			Left Outer Join Language l (Nolock) on l.LanguageId = pah.LanguageId
	Where	p.PolNumber = @PolNumber and
			p.SupplierID = @SupplierID
	Order By DateAdd(hour, -5, pah.ActivityDate)

END
GO
GRANT EXECUTE ON  [dbo].[prc_rpt_GetPolicyActivity] TO [PolicyEXDBReader]
GO
