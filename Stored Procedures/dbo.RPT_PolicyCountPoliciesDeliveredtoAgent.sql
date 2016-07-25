SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- =============================================
-- Author:		Greg Wellbrock
-- Create date: 1/17/2011
-- Description:
--  Number of policies delivered to agent (and from what distributor)

-- =============================================
CREATE PROCEDURE [dbo].[RPT_PolicyCountPoliciesDeliveredtoAgent]
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


	
	SET @StartDate = '1/01/2011'
	SET @EndDate =  '12/31/2011' ;
	
	
Create Table #MonthPivot (DistributorID INT, Name VARCHAR(800),[1] INT,[2] INT,[3] INT,[4] INT,[5] INT,[6] INT,[7] INT,[8] INT,[9] INT,[10] INT,[11] INT,[12] INT)


Insert into #MonthPivot (DistributorID,Name,[1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12])
	
	
	
  SELECT DistributorID, Name, [1] as JAN, [2] as FEB, [3] as MAR, [4] as APR, [5] as MAY, [6] as JUNE, [7] as JULY, [8] as AUG, [9] as SEPT, [10] as OCT, [11] as NOV, [12] as [DEC]


FROM
(
    -- Insert statements for procedure here
SELECT DISTINCT
		
     p.PolicyID,
     d.DistributorID,
     d.Name ,
     DATEPART(mm,p.CreateDate) AS DateMonth
      
    --    p.PolNumber AS PolicyNumber ,
    --    MIN(pah.activitydate) AS DateSentToAgent ,
   --   sdi.IdentifyingValue AS AgencyNumber ,
     --   u.FirstName AS [User First Name] ,
       -- u.LastName AS [User Last Name] ,
       -- u.EmailAddress AS [User Email] ,
       -- ps.PolicyStatusName AS Status
        
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
      AND u.UserTypeID IN ( '4','5', '6')--DCM and DCMA
        AND pah.NewPolicyStatusID = 4 --Sent To Agent
        AND pah.ActivityDate BETWEEN @StartDate AND @EndDate
        
        )
        
        AS P
        
        
Pivot (Count(P.PolicyID) for DateMonth IN ( [1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12] ) 

)
 AS PVT


       SELECT * FROM #MonthPivot     
            
END

DROP TABLE #MonthPivot



GO
GRANT EXECUTE ON  [dbo].[RPT_PolicyCountPoliciesDeliveredtoAgent] TO [PolicyEXDBReader]
GO
