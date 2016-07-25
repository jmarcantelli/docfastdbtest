SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Generate policy reminder notification for PolicyEntity that is not consumer>
-- =============================================
CREATE PROCEDURE [dbo].[prc_GeneratePolicyReminder_Consumer] 	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;	 

	Declare	@SupplierID	Int
	Declare	@PolicyReminding_WaitTime_Consumer	Int
	Declare	@PolicyReminding_MaxOccurrence_Consumer	Int
	Declare	@PolicyReminding_Interval_Consumer	Int
	Declare	@PolicyReminding_WaitTime_ConsumerPrint	Int
	Declare	@PolicyReminding_MaxOccurrence_ConsumerPrint	Int
	Declare	@PolicyReminding_Interval_ConsumerPrint	Int = 0

	DECLARE @ConsumersToRemindTable table(
											consumerID bigint NOT NULL,
											policyID  bigint not null, 
											policydeliverytypeid int null, 
											policystatusid int null
										);


	DECLARE Supplier_Cursor CURSOR FOR SELECT Distinct SupplierID FROM SupplierConfigurations
	OPEN Supplier_Cursor   
	FETCH NEXT FROM Supplier_Cursor INTO @SupplierID

	WHILE @@FETCH_STATUS = 0   
	BEGIN
		Select	@PolicyReminding_WaitTime_Consumer = CAST(sc.configurationvalue as int)
		from	SupplierConfigurations sc
		where	SupplierID = @SupplierID and sc.ConfigurationKey='PolicyReminding_WaitTime_Consumer'

		Select	@PolicyReminding_MaxOccurrence_Consumer = CAST(sc.configurationvalue as int)
		from	SupplierConfigurations sc
		where	SupplierID = @SupplierID and sc.ConfigurationKey='PolicyReminding_MaxOccurrence_Consumer'

		Select	@PolicyReminding_Interval_Consumer = CAST(sc.configurationvalue as int)
		from	SupplierConfigurations sc
		where	SupplierID = @SupplierID and sc.ConfigurationKey='PolicyReminding_Interval_Consumer'

		Select	@PolicyReminding_Interval_ConsumerPrint = CAST(sc.configurationvalue as int)	
		from	SupplierConfigurations sc
		where	SupplierID = @SupplierID and sc.ConfigurationKey='PolicyReminding_Interval_ConsumerPrint'

		Select	@PolicyReminding_WaitTime_ConsumerPrint = CAST(sc.configurationvalue as int)
		from	SupplierConfigurations sc
		where	SupplierID = @SupplierID and sc.ConfigurationKey='PolicyReminding_WaitTime_ConsumerPrint'

		Select	@PolicyReminding_MaxOccurrence_ConsumerPrint = CAST(sc.configurationvalue as int)
		from	SupplierConfigurations sc
		where	SupplierID = @SupplierID and sc.ConfigurationKey='PolicyReminding_MaxOccurrence_ConsumerPrint'

		insert 
		into	@ConsumersToRemindTable (consumerID,policyID,policydeliverytypeid,policystatusid)
				select	cr.consumerrecipientid, cr.policyid , p.policydeliverytypeid, p.policystatusid 
				from	policy p 
						inner join consumerrecipient cr on p.policyid = cr.policyid  
				where	p.SupplierID = @SupplierID
						and p.policystatusid = 5 
						and cr.active=1
						and cr.signerstatusid in (2,3)
						and DATEDIFF(dd,cr.SignerStatusDate,GETUTCDATE()) >= @PolicyReminding_WaitTime_Consumer
						and cr.consumerrecipientid not in (select	ph2.actiontargetconsumerID 
														   from		policyactivityhistory ph2 
																	inner join consumerrecipient cr2 on ph2.policyid = cr2.policyid
														   where	ph2.policyid = cr2.policyid
																	and ph2.actiontargetconsumerId = cr2.consumerrecipientid
																	and ph2.isuserreminded is not null and ph2.activitydate >= cr2.signerstatusdate)
				Union
                Select	cr.consumerrecipientid, cr.policyid , p.policydeliverytypeid, p.PolicyStatusId
                from	PolicyActivityHistory pah (Nolock)
		                Inner Join ConsumerRecipient cr (Nolock) on cr.ConsumerRecipientID = COALESCE(pah.ActionTargetConsumerID, 0)
		                Inner Join Policy p (Nolock) on p.PolicyID = pah.PolicyID
		                Inner Join (Select	PolicyActivityHistoryID = MAX(pah1.PolicyActivityHistoryID), ReminderCount = Count(*) 
									                from	PolicyActivityHistory pah1 (Nolock)
									                where	pah1.NewPolicyStatusID is not null
											                and pah1.PreviousPolicyStatusID is not null
											                and pah1.ActionID = 33
									                group by pah1.PolicyID) pah2 on pah2.PolicyActivityHistoryID = pah.PolicyActivityHistoryID
                Where	p.SupplierID = @SupplierID
		                and pah.ActionID = 33
		                and p.PolicyStatusID = 5 
		                and cr.Active = 1
		                and cr.Signerstatusid in (2, 3)
		                and DATEDIFF(dd, pah.ActivityDate, GETUTCDATE()) >= @PolicyReminding_Interval_Consumer
		                and pah2.ReminderCount <= @PolicyReminding_MaxOccurrence_Consumer
				Union
				Select cr.consumerrecipientid, p.PolicyID, policydeliverytypeid,PolicyStatusId
				FROM Policy p (Nolock)
					INNER JOIN PolicyActivityHistory pah (Nolock) on pah.PolicyID = p.PolicyID
					inner join consumerrecipient cr on p.policyid = cr.policyid  
					WHERE @PolicyReminding_Interval_ConsumerPrint > 0
					AND p.SupplierID = @SupplierID
					AND p.PolicyStatusID = 24
					AND pah.consumerrecipientid IS NOT NULL
					AND pah.NewPolicyStatusID = 24
					AND pah.PreviousPolicyStatusID <> 24
		            AND DATEDIFF(dd, pah.ActivityDate, GETUTCDATE()) >= @PolicyReminding_Interval_ConsumerPrint
					and DATEDIFF(dd,cr.SignerStatusDate,GETUTCDATE()) >= @PolicyReminding_WaitTime_ConsumerPrint
		            AND (SELECT ReminderCount = Count(*) 
						 FROM	PolicyActivityHistory pah1 (Nolock)
						 WHERE	pah1.PolicyID = p.PolicyID
								AND pah1.ActionTargetConsumerID = cr.ConsumerRecipientID
								AND pah1.NewPolicyStatusID  = 24
								AND pah1.PreviousPolicyStatusID  = 24
								AND pah1.ActionID = 33) <= @PolicyReminding_MaxOccurrence_ConsumerPrint
					AND	(Select Count(*)
						FROM	PolicyActivityHistory (Nolock) pah2
						WHERE	pah2.PolicyID = p.PolicyID
								AND pah2.ConsumerRecipientID = cr.ConsumerRecipientID
								AND pah2.NewPolicyStatusID = 24
								AND pah2.PreviousPolicyStatusID = 24
								AND pah2.ActionID = 44) <= 0

		insert 
		into	policynotification (initiatingusertypeid, recipientusertypeid, defaultnotificationtemplateid, isnewnotification, datecreated, policyid)  
		Select distinct		u.usertypeid as initiatingusertypeid,
							  7,
							  nr.notificationtemplatedefaultid,
							  1,
							  getutcdate(),
							  con.policyid
		from      @ConsumersToRemindTable con 
							   inner join notificationrecipient nr on con.policydeliverytypeid = nr.policydeliverytypeid and con.policystatusid = nr.policystatusid
							   Inner Join PolicyUser pu (Nolock) on pu.PolicyID = con.policyID
							   Inner Join [User] u (Nolock) on u.UserID = pu.UserID
							   Inner Join PolicyNotificationToFromUserType tf (nolock) on tf.deliverytypeid = con.policydeliverytypeid and tf.PolicyStatusID = con.policystatusid
												   and tf.InitiatingUserTypeID = u.UserTypeID
				 Where  nr.usertypeid = 7
							   and nr.actionid in (23, 33)
							   and pu.policyroleid <> 2
							   and tf.recipientusertypeid = 7

		Delete From @ConsumersToRemindTable

		FETCH NEXT FROM Supplier_Cursor INTO @SupplierID
	End

	CLOSE Supplier_Cursor
	DEALLOCATE Supplier_Cursor
End

GO
GRANT EXECUTE ON  [dbo].[prc_GeneratePolicyReminder_Consumer] TO [PolicyEXDBReader]
GO
