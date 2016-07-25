SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- Author:		Greg Wellbrock
-- Create date: 11/16/2011
-- Description:	PolicyCountBySupplierPolicyStatus
-- =============================================
CREATE PROCEDURE [dbo].[RPT_PolicyCountBySupplierPolicyStatus]
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
Select	SupplierId, ps.PolicyStatusName, Count(*) as [Policy Count]
From	Policy p
		Left Outer Join PolicyDistributor pd on pd.PolicyID = p.PolicyID
		Inner Join PolicyStatus ps on ps.PolicyStatusID = p.PolicyStatusID
Where	SupplierID = @SupplierID
AND  p.CreateDate >= @StartDate
Group By SupplierId, ps.PolicyStatusName
Order By SupplierID, ps.PolicyStatusName

END

GO
GRANT EXECUTE ON  [dbo].[RPT_PolicyCountBySupplierPolicyStatus] TO [PolicyEXDBReader]
GO
