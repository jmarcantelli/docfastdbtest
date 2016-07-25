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
CREATE PROCEDURE [dbo].[RPT_PoliciesNOTSentToConsumerBySupplierIDTOTAL]
	-- Add the parameters for the stored procedure here

@SupplierID INT,
@ReportTitle VARCHAR(100),
@StartDate DATETIME,
@EndDate DATETIME
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;



	




    -- Insert statements for procedure here
SELECT
		@StartDate AS StartDate,
		@EndDate AS EndDate,
        p.PolicyID ,
        p.PolNumber ,
        MIN(ActivityDate) AS SentDate ,
        sdi.IdentifyingValue AS AgencyNumber ,
        u.FirstName AS [User First Name] ,
        u.LastName AS [User Last Name] ,
        u.EmailAddress AS [User EMail] ,
        ps.PolicyStatusName
        
        
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

        AND u.UserTypeID = 6
        AND p.PolicyStatusID <> '5'
       AND p.PolicyID In (Select PolicyID From PolicyActivityHistory pah1 Where pah1.NewPolicyStatusID = 5)  --Sent to Consumer
 -- and   p.PolicyID Not In (Select PolicyID From PolicyActivityHistory pah1 Where pah1.NewPolicyStatusID = 5)
       -- AND pah.ActivityDate BETWEEN @StartDate AND @EndDate
       AND p.CreateDate BETWEEN @StartDate AND @EndDate








       /* AND u.UserTypeID = 6
    --    And pu.PolicyRoleID = 1
        And p.PolicyID Not In (Select PolicyID From PolicyActivityHistory pah1 Where pah1.NewPolicyStatusID = 5)
        --AND pah.NewPolicyStatusID <> '5'  --Sent to Consumer
        AND p.PolicyStatusID <> '5'

       -- AND pah.ActivityDate BETWEEN @StartDate AND @EndDate
       AND p.CreateDate BETWEEN @StartDate AND @EndDate*/
        
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
GRANT EXECUTE ON  [dbo].[RPT_PoliciesNOTSentToConsumerBySupplierIDTOTAL] TO [PolicyEXDBReader]
GO
