SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[prc_Expire_Single_Consumer] 	
 @policyID bigint,
 @consumerRecipientID bigint,
 @supplierid int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;	 

-- @policyID bigint
-- @consumerRecipientID bigint
-- @supplierid int
declare @NotifyCarrier_OnExpiringConsumer nvarchar(10)
declare @NotifyAgent_OnExpiringConsumer nvarchar(10)
declare @NotifyDCM_OnExpiringConsumer nvarchar(10)
declare @defaulttemplateid_Carrier int
declare @defaulttemplateid_Agent int
declare @defaulttemplateid_DCM int


 
 select @NotifyCarrier_OnExpiringConsumer=configurationvalue
 from supplierConfigurations where supplierid = @supplierid and configurationkey = 'NotifyCarrier_OnConsumerLinkExpire'
 
 select @NotifyAgent_OnExpiringConsumer=configurationvalue
 from supplierConfigurations where supplierid = @supplierid and configurationkey = 'NotifyAgent_OnConsumerLinkExpire'
 
 select @NotifyDCM_OnExpiringConsumer=configurationvalue
 from supplierConfigurations where supplierid = @supplierid and configurationkey = 'NotifyDistributor_OnConsumerLinkExpire'
 
 select @defaulttemplateid_Carrier=notificationtemplateID 
 from NotificationTemplateDefault where originaltemplatename='PolicyNotification_Consumer_Expiration_Carrier'
 
  select @defaulttemplateid_DCM=notificationtemplateID 
 from NotificationTemplateDefault where originaltemplatename='PolicyNotification_Consumer_Expiration_Distributor'
 
  select @defaulttemplateid_Agent=notificationtemplateID 
 from NotificationTemplateDefault where originaltemplatename='PolicyNotification_Consumer_Expiration_Agent'
 
 
 BEGIN TRANSACTION	 
 
 --expiring consumerrecipient 
 update consumerrecipient set signerstatusid = 10, active=0, signerstatusdate = getutcdate() where consumerrecipientid = @consumerrecipientid
 
  --added activityhistory for expiring consumer
  insert into policyactivityhistory (policyid, activitydate,actiontargetconsumerID, actionid)
 values( @policyid, getutcdate(), @consumerrecipientID, 40)
  
 
 insert into dbo.PolicyActivityHistoryDetail (policyactivityhistoryid, activity)
 select  SCOPE_IDENTITY(), c.firstname + ' ' + c.lastname+'''s link has been expired.' 
 from consumerrecipient c where c.consumerrecipientid = @consumerrecipientid
 
 --notify carrier
 if (@NotifyCarrier_OnExpiringConsumer='true')
	begin 
	insert into policynotification (initiatingusertypeid, recipientusertypeid, defaultnotificationtemplateid, isnewnotification, datecreated, policyid,InitiatingUserID)  
	select 7, u.usertypeid, @defaulttemplateid_Carrier,1,getdate(),pu.policyid,@consumerRecipientID
	from policyuser pu inner join [user] u on pu.userid = u.userid where pu.policyid =@policyID and u.usertypeid in (2,3) and pu.policyroleid=1
  end  
  
   --notify DCM
 if (@NotifyDCM_OnExpiringConsumer='true')
	begin 
	insert into policynotification (initiatingusertypeid, recipientusertypeid, defaultnotificationtemplateid, isnewnotification, datecreated, policyid,InitiatingUserID)  
	select 7, u.usertypeid, @defaulttemplateid_DCM,1,getdate(),pu.policyid,@consumerRecipientID
	from policyuser pu inner join [user] u on pu.userid = u.userid where pu.policyid =@policyID and u.usertypeid in (4,5) and pu.policyroleid=1
  end  
  
  
     --notify Agent
 if (@NotifyAgent_OnExpiringConsumer='true')
	begin 
	insert into policynotification (initiatingusertypeid, recipientusertypeid, defaultnotificationtemplateid, isnewnotification, datecreated, policyid,InitiatingUserID)  
	select 7, u.usertypeid, @defaulttemplateid_Agent,1,getdate(),pu.policyid,@consumerRecipientID
	from policyuser pu inner join [user] u on pu.userid = u.userid where pu.policyid =@policyID and u.usertypeid =6 and pu.policyroleid=1
	
  end  
  
 exec [dbo].[prc_PolicyAlertRecalculation]   @PolicyID
  
  
  --select top 1 * from policyuser  	 
commit TRANSACTION	 
	 
SET NOCOUNT OFF;	  
	End
GO
GRANT EXECUTE ON  [dbo].[prc_Expire_Single_Consumer] TO [PolicyEXDBReader]
GO
