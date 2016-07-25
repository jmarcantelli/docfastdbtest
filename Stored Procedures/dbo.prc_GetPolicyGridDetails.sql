SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_GetPolicyGridDetails]  
(  
    @PolicyID int,  
    @SupplierID int,  
    @PolicyStatusID int,  
    @UserID int,  
    @UserTypeID int,  
    @PolicyDeliveryTypeID int,
    @PolicyRoleIDReviewer smallint,
	@LanguageCode nvarchar(100),
    @PolicyStatusName nvarchar(100) output,  
    @PolicyDeliveryTypeDescription varchar(100) output,  
    @PolicyDistributorID int output,  
    @PolicyDistributorName varchar(100) output  
)  
AS  
Begin
	Declare	@DistributorID	int
	Declare	@PolicyRoleID	smallint
	declare @PolicyActions table(ActionID smallint, Action1 nvarchar(100));
	Declare	@LanguageId	SmallInt
	Declare	@PolicyStatusID_Expired	Int

	Select	@LanguageId = LanguageId From [Language] Where Code = @LanguageCode
	Select	@PolicyStatusID_Expired = 32

	-- policystatus  
	select	@PolicyStatusName = Coalesce(psl.PolicyStatusName, ps.PolicyStatusName)
	from	PolicyStatus ps
			Left Outer Join PolicyStatusByLanguage psl on psl.PolicyStatusID = ps.PolicyStatusID and psl.LanguageID = @LanguageId
	where	ps.PolicyStatusID = @PolicyStatusID

	-- policydeliverytype description  
	select @PolicyDeliveryTypeDescription = pdt.Description from PolicyDeliveryType as pdt where pdt.PolicyDeliveryTypeID = @PolicyDeliveryTypeID  

	-- distributor  
	--find the distributor that is associated with current distributor Approver
	Select Top 1 @PolicyDistributorID = coalesce(pu.DistributorID,-1) from PolicyDistributor pu Where PolicyID = @PolicyID Order By DistributionOrder Desc
	Select	@PolicyDistributorName = Coalesce(dbl.Name, d.Name)
	From	Distributor d
			Left Outer Join DistributorByLanguage dbl on dbl.DistributorID = d.DistributorID and dbl.LanguageID = @LanguageId
	Where	d.DistributorID = @PolicyDistributorID

	----user list 
	SELECT	pu.PolicyID, u.UserID, u.UserTypeID, u.FirstName, u.LastName, pu.PolicyRoleID, pu.ESignComplete, 
			ss.signerstatusid, SignerStatusName = Coalesce(ssl.SignerStatusName, ss.SignerStatusName), u.LoginName
	FROM	dbo.PolicyUser AS pu
			join dbo.[User] AS u on pu.UserID = u.UserID
			inner join signerstatus ss on pu.signerstatusid = ss.signerstatusid
			Left Outer Join SignerStatusByLanguage ssl on ssl.SignerStatusID = ss.SignerStatusID and ssl.LanguageID = @LanguageId
	where	[pu].[PolicyID] = @PolicyID

	--dashboard actions
	Select	@PolicyRoleID = ISNULL(pu.PolicyRoleID, @PolicyRoleIDReviewer) From PolicyUser pu Where policyID = @PolicyID and UserID = @UserID
	if @PolicyRoleID is null Select	@PolicyRoleID = @PolicyRoleIDReviewer
	
	insert into @policyactions (actionID,action1)
	Select	a.ActionID, Coalesce(abl.Action, a.Action) AS Action1
	FROM	dbo.DashboardActions AS da
			join dbo.Action AS a on da.ActionID = a.ActionID 
			Left Outer join dbo.ActionByLanguage abl on abl.ActionID = a.ActionID AND abl.LanguageID = @LanguageId
			join dbo.SupplierAllowedDashboardAction AS sa on sa.DashboardActionID = da.DashboardActionID
	where	da.UserTypeID = @UserTypeID
			AND da.PolicyStatusID = @PolicyStatusID
			and da.PolicyRoleID = @PolicyRoleID		
			AND (da.PolicyDeliveryTypeID =@PolicyDeliveryTypeID or da.PolicyDeliveryTypeID is null) 			
			AND sa.SupplierID = @SupplierID

	--Edit Action is allowed on Expired policies for a configured number of days only
	If @PolicyStatusID = @PolicyStatusID_Expired
	Begin
		Declare	@NumberOfDaysEditAllowedOnExpiredPolicy	Int
		Select	@NumberOfDaysEditAllowedOnExpiredPolicy = Coalesce(ConfigurationValue, 0)
		From	SupplierConfigurations (Nolock)
		Where	SupplierID = @SupplierID and ConfigurationKey = 'NumberOfDaysEditAllowedOnExpiredPolicy'

		Declare	@NumberOfDaysPastPolicyExpiration	Int
		Select	@NumberOfDaysPastPolicyExpiration = DateDiff(dd, DeliveryDate, GetDate())
		From	Policy (Nolock)
		Where	PolicyID = @PolicyID

		if(@NumberOfDaysPastPolicyExpiration > @NumberOfDaysEditAllowedOnExpiredPolicy)
			Delete	From @policyactions Where ActionID = 32
	End

	--This is a temporary fix for Hartford to remove Edit action from UI
	--We will be adding a future story to separate available actions between UI and Web service to make it clean
	--When the Clean Fix is implemented, this has to be removed from here
	if @SupplierID = 211
	Begin
		Delete	From @policyactions Where ActionID = 32
	End
	
	if(@UserTypeID=6 and @PolicyStatusID=5)
	begin
	--for conditional signing, we need set policystatusid = 5 when first consumer got policy, we still need "eSign Edelivery button" available for sending policy to rest of consumers.
		if exists (	select consumerRecipientID from consumerrecipient where signerstatusid =1 and policyid = @PolicyID) and
			exists( Select	a.ActionID, a.Action AS Action1	FROM	dbo.DashboardActions AS da	join dbo.Action AS a on da.ActionID = a.ActionID  
			join dbo.SupplierAllowedDashboardAction AS sa on sa.DashboardActionID = da.DashboardActionID
			where	da.UserTypeID = 6	AND da.PolicyStatusID = 4	and da.PolicyRoleID = @PolicyRoleID		AND (da.PolicyDeliveryTypeID =@PolicyDeliveryTypeID or da.PolicyDeliveryTypeID is null) 			
			AND sa.SupplierID = @SupplierID and da.actionid = 18 )
			begin	
			insert into @PolicyActions (actionID, action1)
			select  a.actionid, a.action as action1  from action a where actionid = 18	
			end	
	
	end
	
	SELECT	pa.ActionID, pa.Action1, ag.ActionGroupImage as ActionImage
	from	@PolicyActions pa
			INNER JOIN Action a on a.ActionID = pa.ActionID
			INNER JOIN ActionGroup ag on AG.ActionGroupID = a.ActionGroupID
	ORDER BY ag.SortOrder, a.SortOrder, pa.Action1

	--- alerts
	If(@UserTypeID = 1)
	Begin
		SELECT pa.PolicyAlertID, pa.PolicyID, pa.UserID, pa.AlertTypeID, Coalesce(PABL.AlertText, pa.AlertText) + ' (' + COALESCE(UTBL.UserTypeName, ut.UserTypeName) + ')' as AlertText, pa.AlertRating  
		FROM dbo.PolicyAlert AS pa
		Left Outer Join PolicyAlertByLanguage PABL on PABL.PolicyAlertID = pa.PolicyAlertID and PABL.LanguageID = @LanguageId
		INNER JOIN [User] u on u.UserID = pa.UserID
		INNER JOIN [UserType] ut on ut.UserTypeID = u.UserTypeID
		Left Outer Join UserTypeByLanguage UTBL on UTBL.UserTypeID = ut.UserTypeID and UTBL.LanguageID = @LanguageId
		WHERE (pa.PolicyID = @PolicyID) AND (pa.AlertText IS NOT NULL)  
		ORDER BY u.UserTypeID, pa.AlertRating, pa.AlertText
	End
	Else	If @UserTypeID = 3 
			and Exists(	Select	*	
						From	[User] u 
								inner Join SupplierConfigurations sc on sc.SupplierID = u.SupplierID 
						Where	u.UserID = @UserID and sc.ConfigurationKey = 'CCMACanViewAllPolicyAlertsForCarrier' and UPPER(sc.ConfigurationValue) = 'TRUE')
	Begin
		SELECT	pa.PolicyAlertID, pa.PolicyID, pa.UserID, pa.AlertTypeID 
				, Coalesce(PABL.AlertText, pa.AlertText) + ' (' + u.FirstName + ' ' + u.LastName + ')' as AlertText
				, pa.AlertRating  
		FROM	dbo.PolicyAlert AS pa
				Left Outer Join PolicyAlertByLanguage PABL on PABL.PolicyAlertID = pa.PolicyAlertID and PABL.LanguageID = @LanguageId
				inner Join [User] u on u.UserID = pa.UserID
				INNER JOIN [UserType] ut on ut.UserTypeID = u.UserTypeID
		WHERE	(pa.PolicyID = @PolicyID) AND ((u.SupplierID = @SupplierID) OR (pa.UserID IS NULL)) AND (pa.AlertText IS NOT NULL)  
		ORDER BY pa.AlertRating, pa.AlertText
	End
	Else	If @UserTypeID = 5 
			and Exists(	Select	*	
						From	[User] u 
								inner Join DistributorConfigurations dc on dc.DistributorID = u.DistributorID 
						Where	u.UserID = @UserID and dc.ConfigurationKey = 'DCMACanViewAllPolicyAlertsForDistributor' and UPPER(dc.ConfigurationValue) = 'TRUE')
	Begin
		Select	@DistributorID = DistributorID From [User] Where UserID = @UserID

		SELECT	pa.PolicyAlertID, pa.PolicyID, pa.UserID, pa.AlertTypeID
				, Coalesce(PABL.AlertText, pa.AlertText) + ' (' + u.FirstName + ' ' + u.LastName + ')' as AlertText
				, pa.AlertRating  
		FROM	dbo.PolicyAlert AS pa
				Left Outer Join PolicyAlertByLanguage PABL on PABL.PolicyAlertID = pa.PolicyAlertID and PABL.LanguageID = @LanguageId
				inner Join [User] u on u.UserID = pa.UserID
				INNER JOIN [UserType] ut on ut.UserTypeID = u.UserTypeID
		WHERE	(pa.PolicyID = @PolicyID) AND ((u.DistributorID = @DistributorID) OR (pa.UserID IS NULL)) AND (pa.AlertText IS NOT NULL)  
		ORDER BY pa.AlertRating, pa.AlertText
	End
	Else
	Begin
		SELECT pa.PolicyAlertID, pa.PolicyID, pa.UserID, pa.AlertTypeID, Coalesce(PABL.AlertText, pa.AlertText) as AlertText, pa.AlertRating  
		FROM dbo.PolicyAlert AS pa 
		Left Outer Join PolicyAlertByLanguage PABL on PABL.PolicyAlertID = pa.PolicyAlertID and PABL.LanguageID = @LanguageId
		WHERE (pa.PolicyID = @PolicyID) AND ((pa.UserID = @UserID) OR (pa.UserID IS NULL)) AND (pa.AlertText IS NOT NULL)  
		ORDER BY pa.AlertRating, pa.AlertText
	End
		
	--Consumers	
	select	c.*, ss.SignerStatusCode, SignerStatusName = Coalesce(ssl.SignerStatusName, ss.SignerStatusName), SignerStatusImage
	from	ConsumerRecipient c
			inner join signerstatus ss on c.signerstatusid = ss.signerstatusid
			Left Outer Join SignerStatusByLanguage ssl on ssl.SignerStatusID = ss.SignerStatusID and ssl.LanguageID = @LanguageId
	where	PolicyID = @PolicyID
	
End

GO
GRANT EXECUTE ON  [dbo].[prc_GetPolicyGridDetails] TO [PolicyEXDBReader]
GO
