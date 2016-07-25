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
CREATE PROCEDURE [dbo].[RPT_AllPolicyStatusforCarrierwithDistributor]
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



        SELECT DISTINCT
                p.PolicyID ,
                p.PolNumber ,
                p.ConsumerName ,
                p.CreateDate ,
                ps.PolicyStatusName ,
                MAX(pah.ActivityDate) AS DateStatusChanged ,
                d.Name AS DistributorName ,
                sdi.IdentifyingValue AS SupplierDistributorID
                
        FROM    Policy P
                INNER JOIN dbo.PolicyStatus ps ON ps.PolicyStatusID = p.PolicyStatusID
                LEFT OUTER JOIN dbo.PolicyActivityHistory pah ON pah.PolicyID = p.PolicyID
                LEFT OUTER JOIN PolicyDistributor pd ON pd.PolicyID = p.PolicyID
                LEFT OUTER JOIN Distributor d ON d.DistributorID = pd.DistributorID
                LEFT OUTER JOIN dbo.SupplierDistributorIdentifier sdi ON sdi.DistributorID = d.DistributorID
                
        WHERE   P.SupplierID = @SupplierID
                AND p.CreateDate >= @StartDate
                AND P.CreateDate <= @EndDate
                
        GROUP BY p.PolicyID ,
                p.PolNumber ,
                p.ConsumerName ,
                p.CreateDate ,
                ps.PolicyStatusName ,
                d.Name ,
                sdi.IdentifyingValue
                
                
        ORDER BY sdi.IdentifyingValue ASC ,
                P.PolicyID ASC
            
            
    END



GO
GRANT EXECUTE ON  [dbo].[RPT_AllPolicyStatusforCarrierwithDistributor] TO [PolicyEXDBReader]
GO
