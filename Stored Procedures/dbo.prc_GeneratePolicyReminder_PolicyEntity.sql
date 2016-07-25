SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Generate policy reminder notification for PolicyEntity that is not consumer>
-- =============================================
CREATE PROCEDURE [dbo].[prc_GeneratePolicyReminder_PolicyEntity] 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	BEGIN TRY
		declare @policyID bigint
		declare @consumerRecipientID bigint
		declare @userTypeID smallint
		declare @userID int
		declare @email varchar(250)
		declare @NotificationTemplateDefaultID int
		declare @actualUserID int
		declare @PolicyActivityHistoryID bigint
		declare @Activity nvarchar(250)

		declare @policyStatusID int
		declare @InitiatingUserTypeID int
		declare @RecipientUserTypeID int
		declare @InitiatingUserID int
		declare @policyDeliveryTypeid int
		declare @RecipientUserID int
		declare @HistoryUserID int
		declare @HistoryRecipientUserID bigint
		Declare	@ActionID_PolicyAvailabilityReminder Int
		Select	@ActionID_PolicyAvailabilityReminder = 33

		Declare	@SupplierID	Int
		Declare	@PolicyReminding_WaitTime_Agent	Int
		Declare	@PolicyReminding_MaxOccurrence_Agent	Int
		Declare	@PolicyReminding_Interval_Agent	Int
		
		Declare	@PolicyReminding_WaitTime_Distributor	Int
		Declare	@PolicyReminding_MaxOccurrence_Distributor	Int
		Declare	@PolicyReminding_Interval_Distributor	Int
		
		Declare	@PolicyReminding_WaitTime_Carrier	Int
		Declare	@PolicyReminding_MaxOccurrence_Carrier	Int
		Declare	@PolicyReminding_Interval_Carrier	Int

		DECLARE Supplier_Cursor CURSOR FOR SELECT Distinct SupplierID FROM SupplierConfigurations
		OPEN Supplier_Cursor   
		FETCH NEXT FROM Supplier_Cursor INTO @SupplierID

		WHILE @@FETCH_STATUS = 0   
		BEGIN
			Select	@PolicyReminding_WaitTime_Agent = CAST(sc.configurationvalue as int)	from SupplierConfigurations sc where	SupplierID = @SupplierID and sc.ConfigurationKey='PolicyReminding_WaitTime_Agent'
			Select	@PolicyReminding_MaxOccurrence_Agent = CAST(sc.configurationvalue as int) from SupplierConfigurations sc where SupplierID = @SupplierID and sc.ConfigurationKey='PolicyReminding_MaxOccurrence_Agent'
			Select	@PolicyReminding_Interval_Agent = CAST(sc.configurationvalue as int)	from SupplierConfigurations sc where SupplierID = @SupplierID and sc.ConfigurationKey='PolicyReminding_Interval_Agent'

			Select	@PolicyReminding_WaitTime_Distributor = CAST(sc.configurationvalue as int)	from SupplierConfigurations sc where	SupplierID = @SupplierID and sc.ConfigurationKey='PolicyReminding_WaitTime_Distributor'
			Select	@PolicyReminding_MaxOccurrence_Distributor = CAST(sc.configurationvalue as int) from SupplierConfigurations sc where SupplierID = @SupplierID and sc.ConfigurationKey='PolicyReminding_MaxOccurrence_Distributor'
			Select	@PolicyReminding_Interval_Distributor = CAST(sc.configurationvalue as int)	from SupplierConfigurations sc where SupplierID = @SupplierID and sc.ConfigurationKey='PolicyReminding_Interval_Distributor'

			Select	@PolicyReminding_WaitTime_Carrier = CAST(sc.configurationvalue as int)	from SupplierConfigurations sc where	SupplierID = @SupplierID and sc.ConfigurationKey='PolicyReminding_WaitTime_Carrier'
			Select	@PolicyReminding_MaxOccurrence_Carrier = CAST(sc.configurationvalue as int) from SupplierConfigurations sc where SupplierID = @SupplierID and sc.ConfigurationKey='PolicyReminding_MaxOccurrence_Carrier'
			Select	@PolicyReminding_Interval_Carrier = CAST(sc.configurationvalue as int)	from SupplierConfigurations sc where SupplierID = @SupplierID and sc.ConfigurationKey='PolicyReminding_Interval_Carrier'

			---from policyActivityhistory table, I figure out an entity sitting on policy too long to generate 
			--Alert, email notification
			--if user is consumer, the userid will be consumerrecipientid, hence email also come from consumer recipient table.
			--if user is a system user(agent or distributor), the email come from [user] table.
			DECLARE PolicyActivity_cursor CURSOR  Read_only Fast_forward FOR 
				--First Time
				Select	pah.PolicyID, pah.UserID, pah.ConsumerRecipientID, 
						UserTypeId = u.UserTypeID,
						pah.PolicyActivityHistoryID, pah.newpolicystatusid, p.PolicyDeliveryTypeID	
				from	PolicyActivityHistory pah
						inner join Policy p on p.PolicyID = pah.PolicyID and pah.NewPolicyStatusID = p.PolicyStatusID
						Inner Join [User] u (Nolock) on u.UserID = pah.UserID
						Inner Join (Select	PolicyActivityHistoryID = MAX(pah1.PolicyActivityHistoryID)  
									from	PolicyActivityHistory pah1 (Nolock)
									where	pah1.NewPolicyStatusID is not null
											and pah1.PreviousPolicyStatusID is not null
									group by pah1.PolicyID) pah2 on pah2.PolicyActivityHistoryID = pah.PolicyActivityHistoryID
				where	p.SupplierID = @SupplierID
						and p.PolicyStatusID In (3, 4, 6, 7)
						and COALESCE(pah.IsUserReminded, 0) = 0
						and pah.UserID is Not Null
						and DATEDIFF(dd, pah.ActivityDate, GETUTCDATE()) >= Case u.UserTypeID
																				When 2 Then @PolicyReminding_WaitTime_Carrier
																				When 3 Then @PolicyReminding_WaitTime_Carrier
																				When 4 Then @PolicyReminding_WaitTime_Distributor
																				When 5 Then @PolicyReminding_WaitTime_Distributor
																				When 6 Then @PolicyReminding_WaitTime_Agent
																				Else @PolicyReminding_WaitTime_Carrier
																			End
				Union
				--Already reminded, time for next reminder
				Select	pah.PolicyID, pah.UserID, pah.ConsumerRecipientID, 
						UserTypeId = u.UserTypeID,
						pah.PolicyActivityHistoryID, pah.newpolicystatusid, p.PolicyDeliveryTypeID	
				from	PolicyActivityHistory pah
						inner join Policy p on p.PolicyID = pah.PolicyID and pah.NewPolicyStatusID = p.PolicyStatusID
						Inner Join [User] u (Nolock) on u.UserID = pah.UserID
						Inner Join (Select	PolicyActivityHistoryID = MAX(pah1.PolicyActivityHistoryID), ReminderCount = Count(*) 
									from	PolicyActivityHistory pah1 (Nolock)
									where	pah1.NewPolicyStatusID is not null
											and pah1.PreviousPolicyStatusID is not null
											and pah1.ActionID = @ActionID_PolicyAvailabilityReminder
									group by pah1.PolicyID) pah2 on pah2.PolicyActivityHistoryID = pah.PolicyActivityHistoryID
				where	p.SupplierID = @SupplierID
						and p.PolicyStatusID In (3, 4, 6, 7)
						and pah.UserID is Not Null
						and DATEDIFF(dd, pah.ActivityDate, GETUTCDATE()) >= Case u.UserTypeID
																				When 2 Then @PolicyReminding_Interval_Carrier
																				When 3 Then @PolicyReminding_Interval_Carrier
																				When 4 Then @PolicyReminding_Interval_Distributor
																				When 5 Then @PolicyReminding_Interval_Distributor
																				When 6 Then @PolicyReminding_Interval_Agent
																				Else @PolicyReminding_Interval_Carrier
																			End
						and pah2.ReminderCount <= Case u.UserTypeID
													When 2 Then @PolicyReminding_MaxOccurrence_Carrier
													When 3 Then @PolicyReminding_MaxOccurrence_Carrier
													When 4 Then @PolicyReminding_MaxOccurrence_Distributor
													When 5 Then @PolicyReminding_MaxOccurrence_Distributor
													When 6 Then @PolicyReminding_MaxOccurrence_Agent
													Else @PolicyReminding_MaxOccurrence_Carrier
												End
  
  
			Open PolicyActivity_cursor   
			FETCH NEXT FROM PolicyActivity_cursor
			INTO @policyID,@userID, @consumerRecipientID, @userTypeID,@PolicyActivityHistoryID,@policyStatusID,@policyDeliveryTypeID
	
			WHILE @@FETCH_STATUS = 0   
				BEGIN   
								
					--figuring out the inititing user and notification recipients user type
					--reset the local veriables so it does not carrier over previous row's value
					select @InitiatingUserTypeID=null, @RecipientUserTypeID=null
					select @InitiatingUserID =null, @RecipientUserID=null
			
					select	@InitiatingUserTypeID =	pn.InitiatingUserTypeID,
							@RecipientUserTypeID = pn.RecipientUserTypeID
					from	PolicyNotificationToFromUserType pn
							inner join Policy p on pn.PolicyStatusID = p.PolicyStatusID		
					where	pn.DeliveryTypeID = p.PolicyDeliveryTypeID
							and p.PolicyID=@policyID
							and pn.InitiatingUserTypeID  in (select	u.UserTypeID
															 from	PolicyUser pu 
																	inner join [User] u on pu.UserID = u.UserID
															 where	PolicyID = p.PolicyID	and pu.PolicyRoleID = 1) 
							and (pn.RecipientUserTypeID  in (select u.UserTypeID
															 from	PolicyUser pu
																	inner join [User] u on pu.UserID = u.UserID
															 where	PolicyID =p.PolicyID	and pu.PolicyRoleID=1) ) 
			
					if(ISNULL(@RecipientUserTypeID,0)>0 and ISNULL(@InitiatingUserTypeID,0)>0)
					Begin 
						--figuring out the notification template		
						select	@NotificationTemplateDefaultID = nr.NotificationTemplateDefaultID
						from	NotificationRecipient nr
						where	nr.PolicyDeliveryTypeID = @policyDeliveryTypeid
								and nr.PolicyStatusID = @policyStatusID
								and nr.ActionID = @ActionID_PolicyAvailabilityReminder --policy available reminder
								and nr.UserTypeID = @RecipientUserTypeID

						if Not Exists (Select * From PolicyNotification (NoLock)
						Where PolicyID = @PolicyID and RecipientUserTypeID = @RecipientUserTypeID
								and InitiatingUserTypeID = @InitiatingUserTypeID and DefaultNotificationTemplateID = @NotificationTemplateDefaultID
								and IsNewNotification = 1 and Convert(Varchar, DateCreated, 101) = Convert(Varchar, GETUTCDATE(), 101))
						Begin
							BEGIN TRANSACTION
							---create a policy notification for this policy
							insert into PolicyNotification ( PolicyID, RecipientUserTypeID, InitiatingUserTypeID, DefaultNotificationTemplateID, IsNewNotification, DateCreated	)
							values(@policyID, @RecipientUserTypeID, @InitiatingUserTypeID,@NotificationTemplateDefaultID,1,GETUTCDATE())

							--mark this activity as having already  be notified
							update PolicyActivityHistory set IsUserReminded=1 where PolicyActivityHistoryID=@PolicyActivityHistoryID
							commit TRANSACTION
						End
					End 
					FETCH NEXT FROM PolicyActivity_cursor
					INTO @policyID,@userID, @consumerRecipientID, @userTypeID,@PolicyActivityHistoryID,@policyStatusID,@policyDeliveryTypeID
				END	
				CLOSE PolicyActivity_cursor;
				DEALLOCATE PolicyActivity_cursor
			
				FETCH NEXT FROM Supplier_Cursor INTO @SupplierID
		End

		CLOSE Supplier_Cursor
		DEALLOCATE Supplier_Cursor
	END TRY
	BEGIN CATCH
		CLOSE PolicyActivity_cursor;
		DEALLOCATE PolicyActivity_cursor
		IF @@TRANCOUNT > 0
		BEGIN
			--If any error, Rollback the transaction
			ROLLBACK TRANSACTION
		END
		--CLOSE PolicyActivity_cursor;
		-- Raise an error with the details of the exception
		DECLARE @ErrMsg nvarchar(4000), @ErrSeverity int
		SELECT	@ErrMsg = ERROR_MESSAGE(), @ErrSeverity = ERROR_SEVERITY()
		RAISERROR(@ErrMsg, @ErrSeverity, 1)
	END CATCH
	
END
GO
GRANT EXECUTE ON  [dbo].[prc_GeneratePolicyReminder_PolicyEntity] TO [PolicyEXDBReader]
GO
