SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[prc_PolicyAlertRecalculation]
(
	@PolicyID			BigInt = Null,
	@SupplierID			Int = Null
)
AS
BEGIN
	BEGIN TRY
		Declare	@CurrentDate DateTime
		DECLARE	@Suppliers Table (SupplierID Int)
		Declare @AlertWhenDeliveryDateWithin Int
	
		Declare	@PolicyStatusID_Incomplete	Int
		Declare	@PolicyStatusID_PendingDelivery	Int
	
		Declare	@AlertTypeID_ExtensionRequested	Int
		Declare	@AlertTypeID_ChangeRequested	Int
		Declare	@AlertTypeID_OfferDeclined	Int
		Declare	@AlertTypeID_ConsumerOptOutedofeDelivery	Int
		Declare	@AlertTypeID_ConsumerPolicySuspendedWithTheDetailsProvided	Int
		Declare @AlertTypeID_ReissueRequest Int
	
		Declare	@MessageTypeID_DeliveryDateExtensionRequest	Int
		Declare	@MessageTypeID_ChangeRequestReason	Int
		Declare	@MessageTypeID_DeclinedReason	Int
		Declare	@MessageTypeID_ConsumerOptedOutofElectronicDelivery	Int
		Declare	@MessageTypeID_KnockoutQuestionExplanation	Int
		Declare	@MessageTypeID_ConfirmDeclinedOfferForwardingNotes Int
		Declare @MessageTypeID_ReissueRequest Int
	
		Select	@PolicyStatusID_Incomplete = 1
		Select	@PolicyStatusID_PendingDelivery = 2
	
		Select	@AlertTypeID_ExtensionRequested	= 6
		Select	@AlertTypeID_ChangeRequested	= 4
		Select	@AlertTypeID_OfferDeclined	= 5
		Select	@AlertTypeID_ConsumerOptOutedofeDelivery	= 8
		Select	@AlertTypeID_ConsumerPolicySuspendedWithTheDetailsProvided = 10
		Select	@AlertTypeID_ReissueRequest = 14
	
		Select	@MessageTypeID_DeliveryDateExtensionRequest	= 1
		Select	@MessageTypeID_ChangeRequestReason	= 2
		Select	@MessageTypeID_DeclinedReason	= 3
		Select	@MessageTypeID_ConsumerOptedOutofElectronicDelivery	= 6
		Select	@MessageTypeID_KnockoutQuestionExplanation	= 7
		Select	@MessageTypeID_ConfirmDeclinedOfferForwardingNotes	= 8
		select	@MessageTypeID_ReissueRequest = 9

		Select	@CurrentDate = CONVERT(datetime, FLOOR(CONVERT(float(24), GETDATE())) )

		Declare	@PolicyAlertTemp Table (PolicyID	bigint, UserID	int, AlertTypeID	int, AlertTypeName nvarchar(400), AlertCriteriaID Int, AlertText	nvarchar(Max), AlertRating	tinyint, MessageID bigint)
		Declare	@PolicyAlertTempByLanguage Table (PolicyID	bigint, UserID	int, AlertTypeID	int, AlertTypeName nvarchar(400), AlertCriteriaID Int, AlertText	nvarchar(Max), AlertRating	tinyint, LanguageId smallint, MessageID bigint)
		Declare	@PolicyID_Param	BigInt
			
		Declare	@PolicyMessageTemp Table (MessageText	nvarchar(Max))
		Declare	@PolicyMessageTempCount SmallInt
		Declare	@PolicyMessageValAndTextTmp	nvarchar(max)

		If ISNULL(@PolicyID, -1) <> -1
		Begin
			Insert into @Suppliers(SupplierID)
			Select	SupplierID From Policy (Nolock)
			Where	PolicyID = @PolicyID

			Select	@PolicyID_Param = @PolicyID
		End
		Else If ISNULL(@SupplierID, -1) <> -1
		Begin
			Insert into @Suppliers(SupplierID) Values(@SupplierID)
		End
		Else
		Begin
			Insert into @Suppliers(SupplierID) Select Distinct SupplierID From Policy
		End
		
		DECLARE Supplier_Cursor CURSOR FOR SELECT SupplierID FROM @Suppliers 
		OPEN Supplier_Cursor   
		FETCH NEXT FROM Supplier_Cursor INTO @SupplierID   

		WHILE @@FETCH_STATUS = 0   
		BEGIN
			Delete	@PolicyAlertTempByLanguage
			Delete	@PolicyAlertTemp

			Select	@AlertWhenDeliveryDateWithin = ConfigurationValue 
			From	SupplierConfigurations 
			Where	SupplierID = @SupplierID and ConfigurationKey = 'AlertWhenDeliveryDateWithin'

			DECLARE Policy_Cursor CURSOR FOR SELECT PolicyID FROM Policy (Nolock) Where SupplierID = @SupplierID and PolicyStatusID in (Select Distinct PolicyStatusID From AlertCriteria (Nolock))
			OPEN Policy_Cursor   
			FETCH NEXT FROM Policy_Cursor INTO @PolicyID   

			If ISNULL(@PolicyID_Param, -1) <> -1 Select @PolicyID = @PolicyID_Param

			WHILE @@FETCH_STATUS = 0   
			BEGIN
				Print	@PolicyID
				Delete	@PolicyAlertTempByLanguage
				Delete	@PolicyAlertTemp

				Insert into @PolicyAlertTemp
				(
						PolicyID,
						UserID,
						AlertTypeID,
						AlertTypeName,
						AlertCriteriaID,
						AlertText,
						AlertRating,
						MessageID
				)
				Select	Distinct
						P.PolicyID,
						PU.UserID,
						AC.AlertTypeID,
						at.DisplayName as AlertTypeName,
						AC.AlertCriteriaID,
						AlertText = '<b>' + at.DisplayName + '</b>' + '<Br/>' + ac.AlertText,
						AC.AlertRating,
						Null as MessageID
				from	Policy P (Nolock),
						PolicyUser PU (Nolock),
						[User] U (Nolock),
						AlertCriteria AC (Nolock) Inner join AlertType (Nolock) at on at.AlertTypeID = AC.AlertTypeID,
						ConsumerRecipient CR (Nolock)
				Where	P.PolicyID = @PolicyID and
						--P.DeliveryDate >= @CurrentDate and
						P.PolicyID = CR.PolicyID and
						PU.PolicyID = P.PolicyID and
						U.UserID = PU.UserID and
						(
							--Handles Policy Expiration Alerts When User Type, New Flag & Extension Request are not applicable
							(AC.UserTypeID is Null and AC.PolicyRoleID = PU.PolicyRoleID and AC.PolicyStatusID = P.PolicyStatusID And AC.SignerStatusID is Null and DATEDIFF(dd, GETDATE(), DATEADD(day,1,P.DeliveryDate)) <= ISNULL(@AlertWhenDeliveryDateWithin, AC.DeliveryDateWithin) and AC.NewFlag is Null) Or
							--Handles Policy Expiration Alerts When User Type, Delivery Date, New Flag & Extension Request are not applicable
							(AC.UserTypeID is Null and AC.PolicyRoleID = PU.PolicyRoleID and AC.PolicyStatusID = P.PolicyStatusID And AC.SignerStatusID is Null and AC.DeliveryDateWithin is Null and AC.NewFlag is Null) Or
							--Handles following alert types: Change Requested, Declined Offer, Consumer Opt Out of eDelivery, Canceled by Carrier
							(AC.UserTypeID = U.UserTypeID and AC.PolicyRoleID = PU.PolicyRoleID and AC.PolicyStatusID = P.PolicyStatusID And AC.SignerStatusID is Null and AC.DeliveryDateWithin is Null and AC.NewFlag is Null And AC.AlertTypeID <> @AlertTypeID_ExtensionRequested) Or
							--Handles following alert types: Consumer Fails Login, Consumer Fails ID Check
							(AC.UserTypeID = U.UserTypeID and AC.PolicyRoleID = PU.PolicyRoleID and AC.PolicyStatusID = P.PolicyStatusID and AC.SignerStatusID = CR.SignerStatusID and AC.DeliveryDateWithin is Null and AC.NewFlag is Null) Or
							--Handles New Policy Alerts
							--(AC.UserTypeID Is Null and AC.PolicyRoleID Is Null and AC.PolicyStatusID is Null And AC.SignerStatusID is Null and AC.DeliveryDateWithin is Null and AC.NewFlag = PU.New and P.PolicyStatusID Not In(@PolicyStatusID_Incomplete, @PolicyStatusID_PendingDelivery)) Or
							(AC.UserTypeID = U.UserTypeID and AC.PolicyRoleID = PU.PolicyRoleID and AC.PolicyStatusID = P.PolicyStatusID And AC.SignerStatusID is Null and AC.DeliveryDateWithin is Null and AC.NewFlag = PU.New and PU.PolicyRoleID Not in (3, 4)) or 
							(PU.IsBeingreminded=1 and Ac.alerttypeid = 13)
						)
				Union
		
				--Get Messages that are not included in alerts to Users
				Select	PM.PolicyID,
						PM.ToUserID as UserID,
						Null As AlertTypeID,
						Null as AlertTypeName,
						Null as AlertCriteriaID,
						AlertText = '<b>' + MT.DisplayName + '</b>' + '<Br/>' + PM.MessageText,
						1 as AlertRating,
						PM.MessageID
				From	[PolicyMessage] PM (Nolock)
						Inner Join [Message] M (Nolock) on M.MessageID = PM.MessageID
						Inner Join MessageType MT (Nolock) on MT.MessageTypeID = M.MessageTypeID
				Where	PM.PolicyID = @PolicyID and
						PM.Archived = 0 and
						PM.ToUserID IS NOT NULL and
						M.MessageTypeID Not In(
								--@MessageTypeID_DeliveryDateExtensionRequest,
								@MessageTypeID_ChangeRequestReason,
								@MessageTypeID_DeclinedReason,
								@MessageTypeID_ConsumerOptedOutofElectronicDelivery,
								@MessageTypeID_KnockoutQuestionExplanation)
	
	
				--Update Extension Request Message
				Insert into @PolicyAlertTemp
				Select	pa.PolicyID, pa.UserID, pa.AlertTypeID, pa.AlertTypeName, pa.AlertCriteriaID,
						AlertText = '<b>' + pa.AlertTypeName + ' - ' + m.MessageValue + '</b>' + '<Br/>' + PM.MessageText,
						pa.AlertRating, PM.MessageID
				From	@PolicyAlertTemp	pa
						inner join PolicyMessage PM (Nolock) on PM.PolicyID = pa.PolicyID
						Inner Join [Message] M (Nolock) on M.MessageID = PM.MessageID
				Where	PM.Archived = 0 and
						M.MessageTypeID = @MessageTypeID_DeliveryDateExtensionRequest and
						pa.PolicyID = @PolicyID and
						pa.AlertTypeID = @AlertTypeID_ExtensionRequested
	
			
				--Add Change Requested Message
				Delete	@PolicyMessageTemp
				Insert	Into @PolicyMessageTemp
				Select	Distinct 
						m.MessageValue + '; ' + PM.MessageText
				From	@PolicyAlertTemp	pa
						inner join PolicyMessage PM (Nolock) on PM.PolicyID = pa.PolicyID
						Inner Join [Message] M (Nolock) on M.MessageID = PM.MessageID
				Where	PM.Archived = 0 and
						M.MessageTypeID = @MessageTypeID_ChangeRequestReason and
						pa.PolicyID = @PolicyID and
						pa.AlertTypeID = @AlertTypeID_ChangeRequested
				Select	@PolicyMessageTempCount = @@ROWCOUNT

				if @PolicyMessageTempCount > 1
				Begin
					Select @PolicyMessageValAndTextTmp = (Select	Distinct 
							'<Br/>' + '(' + Convert(Varchar, row_number() over (order by pm.MessageText ASC)) + ') ' +
							pm.MessageText
					From	@PolicyMessageTemp pm
					FOR XML Path(''), type).value('.', 'nvarchar(max)') 
				End
				Else
				Begin
					Select @PolicyMessageValAndTextTmp = '<Br/>' + pm.MessageText	From	@PolicyMessageTemp pm
				End

				Insert into @PolicyAlertTemp
				Select	pa.PolicyID, pa.UserID, pa.AlertTypeID, pa.AlertTypeName, pa.AlertCriteriaID,
						AlertText = '<b>' + pa.AlertTypeName + '</b>' + @PolicyMessageValAndTextTmp,
						pa.AlertRating, Null as MessageID--, PM.MessageID
				From	@PolicyAlertTemp	pa
						inner join PolicyMessage PM (Nolock) on PM.PolicyID = pa.PolicyID
						Inner Join [Message] m (Nolock) on m.MessageID = PM.MessageID
				Where	pa.PolicyID = @PolicyID and
						pa.AlertTypeID = @AlertTypeID_ChangeRequested				
						and PM.PolicyMessageID In ( 
											select	PM2.PolicyMessageID
											from	PolicyMessage PM2 (Nolock)
													Inner Join [Message] M2 (Nolock) on M2.MessageID = PM2.MessageID
											where	PM2.PolicyID=@PolicyID
													and M2.MessageTypeID = @MessageTypeID_ChangeRequestReason
													and	PM2.Archived = 0)
				
				--Add Offer Declined Message
				Delete	@PolicyMessageTemp
				Insert	Into @PolicyMessageTemp
				Select	Distinct 
						m.MessageValue + '; ' + PM.MessageText
						From	@PolicyAlertTemp	pa
								inner join PolicyMessage PM (Nolock) on PM.PolicyID = pa.PolicyID
								Inner Join [Message] M (Nolock) on M.MessageID = PM.MessageID
						Where	PM.Archived = 0 and
								M.MessageTypeID = @MessageTypeID_DeclinedReason and
								pa.PolicyID = @PolicyID and
								pa.AlertTypeID = @AlertTypeID_OfferDeclined
				Select	@PolicyMessageTempCount = @@ROWCOUNT

				if @PolicyMessageTempCount > 1
				Begin
					Select @PolicyMessageValAndTextTmp = (Select	Distinct 
							'<Br/>' + '(' + Convert(Varchar, row_number() over (order by pm.MessageText ASC)) + ') ' +
							pm.MessageText
					From	@PolicyMessageTemp pm
					FOR XML Path(''), type).value('.', 'nvarchar(max)') 
				End
				Else
				Begin
					Select @PolicyMessageValAndTextTmp = '<Br/>' + pm.MessageText	From	@PolicyMessageTemp pm
				End

				Insert into @PolicyAlertTemp
				Select	Distinct pa.PolicyID, pa.UserID, pa.AlertTypeID, pa.AlertTypeName, pa.AlertCriteriaID,
						AlertText = '<b>' + pa.AlertTypeName + '</b>' + (
																				COALESCE(
																							(
																								Select	Distinct '<Br/>' + PM.MessageText
																								From	@PolicyAlertTemp	pa
																										inner join PolicyMessage PM (Nolock) on PM.PolicyID = pa.PolicyID
																										Inner Join [Message] M (Nolock) on M.MessageID = PM.MessageID
																										Inner join [User] u (Nolock) on u.UserID = PM.FromUserID
																										inner join UserType ut (Nolock) on u.UserTypeID= ut.UserTypeID
																								Where	PM.Archived = 0 and
																										M.MessageTypeID = @MessageTypeID_ConfirmDeclinedOfferForwardingNotes and
																										pa.PolicyID = @PolicyID and
																										pa.AlertTypeID = @AlertTypeID_OfferDeclined
																							) + '<Br/>', '')
																				+ '<Br/>' + '<b>Reasons for decline</b>:' + @PolicyMessageValAndTextTmp
																			),
						pa.AlertRating, Null as MessageID--PM.MessageID
				From	@PolicyAlertTemp	pa
						inner join PolicyMessage PM (Nolock) on PM.PolicyID = pa.PolicyID
						Inner Join [Message] M (Nolock) on M.MessageID = PM.MessageID
				Where	PM.Archived = 0 and
						M.MessageTypeID = @MessageTypeID_DeclinedReason and
						pa.PolicyID = @PolicyID and
						pa.AlertTypeID = @AlertTypeID_OfferDeclined
	
				
				--Update Consumer Opt Outed of eDelivery Message
				Insert into @PolicyAlertTemp
				Select	pa.PolicyID, pa.UserID, pa.AlertTypeID, pa.AlertTypeName, pa.AlertCriteriaID,
						AlertText = '<b>' + pa.AlertTypeName + ' - ' + m.MessageValue + '</b>' + '<Br/>' + PM.MessageText,
						pa.AlertRating, PM.MessageID
				From	@PolicyAlertTemp	pa
						inner join PolicyMessage PM (Nolock) on PM.PolicyID = pa.PolicyID
						Inner Join [Message] M (Nolock) on M.MessageID = PM.MessageID
				Where	PM.Archived = 0 and
						M.MessageTypeID = @MessageTypeID_ConsumerOptedOutofElectronicDelivery and
						pa.PolicyID = @PolicyID and
						pa.AlertTypeID = @AlertTypeID_ConsumerOptOutedofeDelivery			
				
				--Add Reissue Request Message (Declined Reason From Consumer)
				Delete	@PolicyMessageTemp
				Insert	Into @PolicyMessageTemp
				Select	Distinct 
						m.MessageValue + '; ' + PM.MessageText
						From	@PolicyAlertTemp	pa
						inner join PolicyMessage PM (Nolock) on PM.PolicyID = pa.PolicyID
						Inner Join [Message] M (Nolock) on M.MessageID = PM.MessageID
				Where	PM.Archived = 0 and
						M.MessageTypeID = @MessageTypeID_DeclinedReason and
						pa.PolicyID = @PolicyID and
						pa.AlertTypeID = @AlertTypeID_ReissueRequest
				Select	@PolicyMessageTempCount = @@ROWCOUNT

				if @PolicyMessageTempCount > 1
				Begin
					Select @PolicyMessageValAndTextTmp = (Select	Distinct 
							'<Br/>' + '(' + Convert(Varchar, row_number() over (order by pm.MessageText ASC)) + ') ' +
							pm.MessageText
					From	@PolicyMessageTemp pm
					FOR XML Path(''), type).value('.', 'nvarchar(max)') 
				End
				Else
				Begin
					Select @PolicyMessageValAndTextTmp = '<Br/>' + pm.MessageText	From	@PolicyMessageTemp pm
				End

				Insert into @PolicyAlertTemp
				Select	Distinct pa.PolicyID, pa.UserID, pa.AlertTypeID, pa.AlertTypeName, pa.AlertCriteriaID,
						AlertText = '<b>' + pa.AlertTypeName + '</b><Br/>' + (
																				COALESCE(
																							(
																								Select	Distinct PM.MessageText
																								From	@PolicyAlertTemp	pa
																										inner join PolicyMessage PM (Nolock) on PM.PolicyID = pa.PolicyID
																										Inner Join [Message] M (Nolock) on M.MessageID = PM.MessageID
																										Inner join [User] u (Nolock) on u.UserID = PM.FromUserID
																										inner join UserType ut (Nolock) on u.UserTypeID= ut.UserTypeID
																								Where	PM.Archived = 0 and
																										M.MessageTypeID = @MessageTypeID_ReissueRequest and
																										pa.PolicyID = @PolicyID and
																										pa.AlertTypeID = @AlertTypeID_ReissueRequest
																							) + '<Br/>', '')
																				+ '<Br/>' + '<b>Reasons for decline</b>:' + @PolicyMessageValAndTextTmp
																			),
						pa.AlertRating, Null as MessageID--PM.MessageID
				From	@PolicyAlertTemp	pa
						inner join PolicyMessage PM (Nolock) on PM.PolicyID = pa.PolicyID
						Inner Join [Message] M (Nolock) on M.MessageID = PM.MessageID
				Where	PM.Archived = 0 and
						M.MessageTypeID = @MessageTypeID_DeclinedReason and
						pa.PolicyID = @PolicyID and
						pa.AlertTypeID = @AlertTypeID_ReissueRequest

				--Update Consumer Policy Suspended with the details the consumer provided Message
				Insert into @PolicyAlertTemp
				Select	pa.PolicyID, pa.UserID, pa.AlertTypeID, pa.AlertTypeName, pa.AlertCriteriaID,
						AlertText = '<b>' + pa.AlertTypeName + ' - ' + m.MessageValue + '</b>' + '<Br/>' + PM.MessageText,
						pa.AlertRating, PM.MessageID
				From	@PolicyAlertTemp	pa
						inner join PolicyMessage PM (Nolock) on PM.PolicyID = pa.PolicyID
						Inner Join [Message] M (Nolock) on M.MessageID = PM.MessageID
				Where	PM.Archived = 0 and
						M.MessageTypeID = @MessageTypeID_KnockoutQuestionExplanation and
						pa.PolicyID = @PolicyID and
						pa.AlertTypeID = @AlertTypeID_ConsumerPolicySuspendedWithTheDetailsProvided		
				
				-- Update Policy Alert Text By Language with reissue request notes:
				update	@PolicyAlertTempByLanguage 
				set		AlertText = AlertText + ' ' +  isnull(ut.UserTypeName, ' ') +'  Notes: ' + PM.MessageText, pa.MessageID = PM.MessageID
				from	@PolicyAlertTempByLanguage pa
						inner join  PolicyMessage PM (Nolock) on pa.PolicyID= PM.PolicyID and  pa.AlertTypeID = @AlertTypeID_ReissueRequest
						left outer join [User] u (Nolock) on u.UserID = PM.FromUserID
						inner join UserType ut (Nolock) on u.UserTypeID= ut.UserTypeID
						Inner Join [Message] M (Nolock) on M.MessageID = PM.MessageID
				where   M.MessageTypeID = 3 and   PM.PolicyMessageID =  (
																	Select	MAX(PM2.PolicyMessageID)
																	from	PolicyMessage PM2 (Nolock)
																			Inner Join [Message] M2 (Nolock) on M2.MessageID = PM2.MessageID
																	where	PM2.PolicyID = @policyid and M2.MessagetypeID = 3 and Archived=0)
						and pa.PolicyID = @PolicyID

				--Insert Alerts On Supplier Supported Languages
				Insert into @PolicyAlertTempByLanguage
				Select	PAT.PolicyID,
						PAT.UserID,
						PAT.AlertTypeID,
						'' as AlertTypeName,
						PAT.AlertCriteriaID,
						AlertText = '<b>' + atbl.DisplayName + '</b>' + '<Br/>' + ACBL.AlertText,
						PAT.AlertRating,
						sl.LanguageId,
						PAT.MessageID
				from	@PolicyAlertTemp PAT
							Inner Join AlertCriteriaByLanguage ACBL (Nolock) on ACBL.AlertCriteriaID = PAT.AlertCriteriaID
							Inner Join AlertType at (Nolock) on at.AlertTypeID = PAT.AlertTypeID
							Inner Join SupplierLanguage sl (Nolock) on sl.LanguageId = ACBL.LanguageId
							Left Outer Join AlertTypeByLanguage (Nolock) atbl on PAT.AlertTypeID = atbl.AlertTypeID and atbl.LanguageID = sl.LanguageId
				Where	sl.SupplierID = @SupplierID
				Union
				Select	PM.PolicyID,
						PM.ToUserID as UserID,
						Null As AlertTypeID,
						Null as AlertTypeName,
						Null as AlertCriteriaID,
						AlertText = '<b>' + mtbl.DisplayName + '</b>' + '<Br/>' + PM.MessageText,
						1 as AlertRating,
						sl.LanguageId,
						PM.MessageID
				From	PolicyMessage PM (Nolock)
						Inner join (	Select	PolicyMessageID = Max(PolicyMessageID)--Take only the latest if there are more than one reasons for a message
										From	PolicyMessage PM1 (Nolock)
												Inner Join @PolicyAlertTemp pa1 on PM1.PolicyID = pa1.PolicyID and PM1.MessageID = pa1.MessageID
										Group By PM1.PolicyID, PM1.MessageID) PM2 on PM2.PolicyMessageID = PM.PolicyMessageID
						Inner Join [Message] M (Nolock) on M.MessageID = PM.MessageID
						Inner Join MessageTypeByLanguage (Nolock) mtbl on mtbl.MessageTypeID = M.MessageTypeID
						Inner Join SupplierLanguage sl (Nolock) on sl.LanguageId = mtbl.LanguageID
						Left Outer Join MessageByLanguage mbl (Nolock) on M.MessageID = mbl.MessageID
				Where	PM.PolicyID = @PolicyID and
						PM.Archived = 0 and
						PM.ToUserID IS NOT NULL and
						M.MessageTypeID Not In(
								--@MessageTypeID_DeliveryDateExtensionRequest,
								@MessageTypeID_ChangeRequestReason,
								@MessageTypeID_DeclinedReason,
								@MessageTypeID_ConsumerOptedOutofElectronicDelivery,
								@MessageTypeID_KnockoutQuestionExplanation)
						and sl.SupplierID = @SupplierID

				--Policy Alert Text By Language with Message
				Insert	into @PolicyAlertTempByLanguage
				Select	pabl.PolicyID,
						pabl.UserID,
						pabl.AlertTypeID,
						pabl.AlertTypeName,
						pabl.AlertCriteriaID,
						AlertText = '<b>' + Coalesce(atbl.DisplayName, at.DisplayName) + ' - ' + Coalesce(mbl.MessageValue, m.MessageValue, '') + '</b>' + '<Br/>' + COALESCE(PM.MessageText, ''),
						pabl.AlertRating,
						pabl.LanguageId,
						pabl.MessageID
				From	@PolicyAlertTempByLanguage pabl
						Inner Join AlertType at (Nolock) on at.AlertTypeID = pabl.AlertTypeID
						Left Outer Join AlertTypeByLanguage atbl (nolock) on at.AlertTypeID = atbl.AlertTypeID and atbl.LanguageID = pabl.LanguageId
						Inner join PolicyMessage PM (Nolock) on pabl.PolicyID = PM.PolicyID and pabl.MessageID = PM.MessageID and PM.PolicyID = @PolicyID
						Inner join (	Select	PolicyMessageID = Max(PolicyMessageID) --Take only the latest if there are more than one reasons for a message
										From	PolicyMessage PM1 (Nolock)
												Inner Join @PolicyAlertTempByLanguage pabl1 on PM1.PolicyID = pabl1.PolicyID and PM1.MessageID = pabl1.MessageID
										Group By PM1.PolicyID, PM1.MessageID) PM2 on PM2.PolicyMessageID = PM.PolicyMessageID
						Inner Join [Message] m (Nolock) on m.MessageID = pabl.MessageID
						Left Outer Join MessageByLanguage mbl (Nolock) on m.MessageID = mbl.MessageID and mbl.LanguageId = pabl.LanguageID

				BEGIN TRANSACTION
				Delete	PATBL
				From	PolicyAlertByLanguage PATBL
						Inner Join PolicyAlert PA (Nolock) on PA.PolicyAlertID = PATBL.PolicyAlertID
				Where	PA.PolicyID = @PolicyID

				Delete	PolicyAlert Where PolicyID = @PolicyID
				Insert	Into PolicyAlert (PolicyID, UserID, AlertTypeID, AlertText, AlertRating, MessageID)
				Select	Distinct PolicyID, UserID, AlertTypeID, AlertText, AlertRating, MessageID
				From	@PolicyAlertTemp
				Where	Right(AlertText, 9) <> '[Message]'
		
				Insert Into PolicyAlertByLanguage 
				Select	PA.PolicyAlertID, PATBL.LanguageId, PATBL.AlertText 
				From	@PolicyAlertTempByLanguage PATBL
						Inner Join PolicyAlert PA (Nolock) on	PA.PolicyID = PATBL.PolicyID 
														and PA.UserID = PATBL.UserID
														and COALESCE(PA.AlertTypeID, 0) = COALESCE(PATBL.AlertTypeID, 0)
														and COALESCE(PA.MessageID, 0) = COALESCE(PATBL.MessageID, 0)
				Where	PATBL.LanguageId IS Not Null and Right(PATBL.AlertText, 9) <> '[Message]'

				--Commit the transaction
				Commit TRANSACTION

				If ISNULL(@PolicyID_Param, -1) <> -1 Break

				FETCH NEXT FROM Policy_Cursor INTO @PolicyID   
			END   

			CLOSE Policy_Cursor   
			DEALLOCATE Policy_Cursor 

			FETCH NEXT FROM Supplier_Cursor INTO @SupplierID   
		END   

		CLOSE Supplier_Cursor   
		DEALLOCATE Supplier_Cursor 
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0
		BEGIN
			--If any error, Rollback the transaction
			ROLLBACK TRANSACTION
		END

		-- Raise an error with the details of the exception
		DECLARE @ErrMsg nvarchar(4000), @ErrSeverity int
		SELECT	@ErrMsg = ERROR_MESSAGE(), @ErrSeverity = ERROR_SEVERITY()

		RAISERROR(@ErrMsg, @ErrSeverity, 1)
	END CATCH
END
GO
GRANT EXECUTE ON  [dbo].[prc_PolicyAlertRecalculation] TO [PolicyEXDBReader]
GO
