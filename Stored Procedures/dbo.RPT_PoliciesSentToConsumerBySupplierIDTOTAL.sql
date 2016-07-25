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
CREATE PROCEDURE [dbo].[RPT_PoliciesSentToConsumerBySupplierIDTOTAL]
	-- Add the parameters for the stored procedure here
    @SupplierID INT ,
    @ReportTitle VARCHAR(100) ,
    @StartDate DATETIME ,
    @EndDate DATETIME
AS 
    BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
        SET NOCOUNT ON ;



	




    -- Insert statements for procedure here
        SELECT  p.PolicyID ,
                p.PolNumber ,
                p.CreateDate AS SentDate ,
                min(DISTINCT pah.ActivityDate) AS [Date Sent To Consumer] ,
                Min(DISTINCT pah1.ActivityDate) AS [Date Requirements Recieved] ,
 --       pah1.ActivityDate - pah.ActivityDate AS [Difference],
                sdi.IdentifyingValue AS AgencyNumber ,
                u.FirstName AS [User First Name] ,
                u.LastName AS [User Last Name] ,
                u.EmailAddress AS [User EMail] ,
                cr.EmailAddress AS [Consumer Email] ,
                ps.PolicyStatusName
       
       
        FROM    dbo.Policy P
                INNER JOIN PolicyActivityHistory pah ON pah.PolicyID = p.PolicyID
                INNER JOIN dbo.PolicyActivityHistory pah1 ON pah1.PolicyID = p.PolicyID
                INNER JOIN PolicyUser pu ON pu.PolicyID = p.PolicyID
                INNER JOIN [User] u ON u.UserID = pu.UserID
                INNER JOIN dbo.PolicyStatus ps ON ps.PolicyStatusID = p.PolicyStatusID
                INNER JOIN dbo.Distributor d ON d.DistributorID = u.DistributorID
                INNER JOIN dbo.UserType ut ON ut.UserTypeID = u.UserTypeID
                INNER JOIN dbo.ConsumerRecipient cr ON cr.PolicyID = p.PolicyID
                INNER JOIN dbo.SupplierDistributorIdentifier sdi ON sdi.DistributorID = d.DistributorID
     
     
        WHERE   p.SupplierID = @SupplierID
                AND u.UserTypeID = 6
                AND p.PolicyID IN ( SELECT  PolicyID
                                    FROM    dbo.PolicyActivityHistory
                                    WHERE   NewPolicyStatusID = 5 )
                AND p.CreateDate BETWEEN @StartDate AND @EndDate
                AND pah.NewPolicyStatusID = '5'
                AND pah1.NewPolicyStatusID = '24'
      
      
        GROUP BY p.PolicyID ,
                p.PolNumber ,
                p.CreateDate ,
                pah.ActivityDate ,
                pah1.ActivityDate ,
                sdi.IdentifyingValue ,
                u.FirstName ,
                u.LastName ,
                u.EmailAddress ,
                cr.EmailAddress ,
                ps.PolicyStatusName
        ORDER BY 3 DESC
            
            
    END



GO
GRANT EXECUTE ON  [dbo].[RPT_PoliciesSentToConsumerBySupplierIDTOTAL] TO [PolicyEXDBReader]
GO
