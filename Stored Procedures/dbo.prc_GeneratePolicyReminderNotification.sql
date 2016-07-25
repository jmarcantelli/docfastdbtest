SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Generate policy reminder notification for PolicyEntity that is not consumer>
-- =============================================
CREATE PROCEDURE [dbo].[prc_GeneratePolicyReminderNotification] 	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    BEGIN TRY
        --Generate Policy Notification records for Policy Approvers
        execute dbo.prc_GeneratePolicyReminder_PolicyEntity

        --Generate Policy Notification records for consumers
        execute dbo.prc_GeneratePolicyReminder_Consumer

        --Expire consumers
        execute dbo.prc_Expire_consumers
    END TRY
	BEGIN CATCH
	
		--CLOSE PolicyActivity_cursor;
		-- Raise an error with the details of the exception
		DECLARE @ErrMsg nvarchar(4000), @ErrSeverity int
		SELECT	@ErrMsg = ERROR_MESSAGE(), @ErrSeverity = ERROR_SEVERITY()
		RAISERROR(@ErrMsg, @ErrSeverity, 1)
	END CATCH
	
END

GO
GRANT EXECUTE ON  [dbo].[prc_GeneratePolicyReminderNotification] TO [PolicyEXDBReader]
GO
