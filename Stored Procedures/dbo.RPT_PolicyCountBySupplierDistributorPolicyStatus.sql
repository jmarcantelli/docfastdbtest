SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- Author:		Greg Wellbrock
-- Create date: 11/16/2011
-- Description:	PolicyCountBySupplierDistributorPolicyStatus
-- =============================================
CREATE PROCEDURE [dbo].[RPT_PolicyCountBySupplierDistributorPolicyStatus]
	-- Add the parameters for the stored procedure here

@SupplierID INT,
@StartDate DATETIME,
@ReportTitle VARCHAR(100)






AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here



Select	p.SupplierID, d.Name as Distributor,sdi.IdentifyingValue AS AgencyNumber, ps.PolicyStatusName, Count(*) as [Policy Count]
From	Policy p
		Left Outer Join PolicyDistributor pd on pd.PolicyID = p.PolicyID
		Left Outer join Distributor d on d.DistributorID = pd.DistributorID
		Inner Join PolicyStatus ps on ps.PolicyStatusID = p.PolicyStatusID
		INNER JOIN dbo.SupplierDistributorIdentifier sdi ON sdi.DistributorID = d.DistributorID
Where	pd.DistributionOrder = 1

		and p.SupplierID = @SupplierID
		AND p.CreateDate >= @StartDate
		and sdi.SupplierID = @SupplierID
		
		
		GROUP BY p.SupplierID, d.name,sdi.IdentifyingValue,ps.PolicyStatusName

	Order By p.SupplierID, d.Name, ps.PolicyStatusName




END

GO
GRANT EXECUTE ON  [dbo].[RPT_PolicyCountBySupplierDistributorPolicyStatus] TO [PolicyEXDBReader]
GO
