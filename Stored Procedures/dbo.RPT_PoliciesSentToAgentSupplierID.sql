SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- Author:		Greg Wellbrock
-- Create date: 11/16/2011
-- Description:	Created originally for STANDARD INS
-- This Shows all policies that were put into sent to agent status in the last week

-- =============================================
CREATE PROCEDURE [dbo].[RPT_PoliciesSentToAgentSupplierID]
	-- Add the parameters for the stored procedure here

@SupplierID INT,
@ReportTitle VarChar(50)


AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;



DECLARE @StartDate DATETIME
DECLARE @EndDate DATETIME


	
	SET @StartDate = dateadd(DAY, datediff(day, 7, GETDATE()),0) 
	SET @EndDate =  dateadd(DAY, datediff(day, 0, GETDATE()),0) ;



    -- Insert statements for procedure here
SELECT DISTINCT
		@StartDate AS StartDate,
		@EndDate AS EndDate,
        p.PolicyID AS PolicyID,
        p.PolNumber AS PolicyNumber ,
        MIN(pah.activitydate) AS DateSentToAgent ,
        sdi.IdentifyingValue AS AgencyNumber ,
        u.FirstName AS [User First Name] ,
        u.LastName AS [User Last Name] ,
        u.EmailAddress AS [User Email] ,
        ps.PolicyStatusName AS Status
        
FROM    dbo.Policy P

        INNER JOIN PolicyActivityHistory pah ON pah.PolicyID = p.PolicyID
        INNER JOIN PolicyUser pu ON pu.PolicyID = p.PolicyID
        INNER JOIN [User] u ON u.UserID = pu.UserID
        INNER JOIN dbo.PolicyStatus ps ON ps.PolicyStatusID = p.PolicyStatusID
        INNER JOIN dbo.Distributor d ON d.DistributorID = u.DistributorID
        INNER JOIN dbo.UserType ut ON ut.UserTypeID = u.UserTypeID
        INNER JOIN dbo.ConsumerRecipient cr ON cr.PolicyID = p.PolicyID
        INNER JOIN dbo.SupplierDistributorIdentifier sdi ON sdi.DistributorID = d.DistributorID
        
WHERE   p.SupplierID = @SupplierID
        AND u.UserTypeID IN ( '4', '5' ) --DCM and DCMA
        AND pah.NewPolicyStatusID = 4 --Sent To Agent
        AND pah.ActivityDate BETWEEN @StartDate AND @EndDate
        
        
GROUP BY p.PolicyID ,
         p.PolNumber ,
         sdi.IdentifyingValue ,
         u.FirstName ,
         u.LastName ,
         u.EmailAddress ,
         ps.PolicyStatusName
         
ORDER BY 3 DESC
            
            
END

GO
GRANT EXECUTE ON  [dbo].[RPT_PoliciesSentToAgentSupplierID] TO [PolicyEXDBReader]
GO
