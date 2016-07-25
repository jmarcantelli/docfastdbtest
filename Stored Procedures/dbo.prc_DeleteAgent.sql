SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[prc_DeleteAgent] 
	-- Add the parameters for the stored procedure here
	@AgentID int,
	@CanDelete bit output	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	select @CanDelete=1;
	
	if not exists (select policyID from policyuser where userid = @AgentID)
	begin
		begin Tran
	
		delete from  dbo.SupplierUserIdentifier where userid =  @AgentID
	
		delete from [user] where userid = @AgentID
	  
	  
	  commit
	end
	else
		select @CanDelete=0    
END
GO
GRANT EXECUTE ON  [dbo].[prc_DeleteAgent] TO [PolicyEXDBReader]
GO
