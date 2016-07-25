SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[prc_Expire_Consumers] 	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;	 

	declare @RowsToProcess int
	declare @PolicyID bigint
	declare @consumerID bigint
	declare @supplierid int

	DECLARE @ConsumersToExpireTable table(
		RowID [bigint] IDENTITY(1,1) NOT NULL ,
		consumerID bigint NOT NULL,
		policyID  bigint not null, 
		supplierid int null
	)
	
	insert @ConsumersToExpireTable (consumerid, policyid, supplierid)
	select cr.consumerrecipientid,cr.policyid , sc.supplierid
	from consumerrecipient cr inner join policy p on cr.policyid = p.policyid 
		inner join supplierconfigurations sc  on sc.supplierid = p.supplierid and sc.configurationkey='DaysConsumerLinkExpires' and cast(sc.configurationvalue as int) > 0 
	where DATEDIFF(ss,cr.signerstatusDate,GETUTCDATE()) - (cast(sc.configurationvalue as int) * 24 * 60 * 60) >=0 and cr.signerstatusid in (2,3)
 
	select @RowsToProcess = max(RowID)
	from @ConsumersToExpireTable 
 
	while @RowsToProcess>0
	begin
 
		select @PolicyID = policyid,@consumerID = consumerId, @supplierid = supplierid 
		from @ConsumersToExpireTable where rowid = @RowsToProcess
 
		select @RowsToProcess= @RowsToProcess-1; 
		
		execute prc_expire_single_consumer @policyid = @policyid,@ConsumerRecipientID = @ConsumerID, @supplierID = @supplierid 
	end 
	SET NOCOUNT OFF;
	 
End
GO
GRANT EXECUTE ON  [dbo].[prc_Expire_Consumers] TO [PolicyEXDBReader]
GO
