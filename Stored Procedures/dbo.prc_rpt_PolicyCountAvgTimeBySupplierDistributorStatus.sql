SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[prc_rpt_PolicyCountAvgTimeBySupplierDistributorStatus]

(
	@SupplierID		Int,
	@StartDate	Varchar(10),
	@EndDate	Varchar(10)
)
AS
Begin
	Declare	@TotalPolicyCreated	Int
	Declare	@TotalSentToDistributor	Int
	Declare	@TotalPolicyPrintedBySupplier	Int
	Declare	@TotalPolicyPrintedByDistributor	Int
	Declare	@TotalPolicyPrintedByAgent	Int
	Declare	@TotalSentToConsumer	Int
	Declare	@TotalChangeRequestedByCarrier	Int
	Declare	@TotalChangeRequestedByDistributor	Int
	Declare	@TotalChangeRequestedByAgent	Int
	Declare	@TotalChangeRequestedByConsumer Int
	Declare	@TotalReissueRequestByAgent Int
	Declare	@TotalPolicyESigned	Int
	Declare	@TotalPolicyDeclinedByConsumer	Int
	Declare	@WaitingAtDistributor	Int
	Declare	@WaitingAtAgent	Int

	declare @PolicyToConsider table (PolicyID BigInt NOT NULL, SupplierID Int Not Null, PolicyStatusID int Not Null)
	Insert
	Into	@PolicyToConsider (PolicyID, SupplierID, PolicyStatusID)
			Select	PolicyID, SupplierID, PolicyStatusID From Policy(Nolock)
			Where	SupplierID = @SupplierID and CreateDate >= @StartDate and CreateDate < DateAdd(d, 1, @EndDate)

	Select	@TotalPolicyCreated = Count(*) From @PolicyToConsider Where SupplierID = @SupplierID
	Select	@TotalSentToDistributor = Count(Distinct p.PolicyID) From @PolicyToConsider p Inner Join PolicyActivityHistory pah (Nolock) on pah.PolicyID = p.PolicyID and p.SupplierID = @SupplierID and pah.NewPolicyStatusID = 3
	Select	@TotalPolicyPrintedByDistributor = Count(*) From @PolicyToConsider Where SupplierID = @SupplierID and PolicyStatusID = 21
	Select	@TotalPolicyPrintedByAgent = Count(*) From @PolicyToConsider Where SupplierID = @SupplierID and PolicyStatusID = 22
	Select	@TotalSentToConsumer = Count(Distinct p.PolicyID) From @PolicyToConsider p Inner Join PolicyActivityHistory pah (Nolock) on pah.PolicyID = p.PolicyID and p.SupplierID = @SupplierID and pah.NewPolicyStatusID = 5
	Select	@TotalPolicyESigned = Count(*) From @PolicyToConsider Where SupplierID = @SupplierID and PolicyStatusID = 24
	Select	@TotalPolicyDeclinedByConsumer = Count(Distinct p.PolicyID) From @PolicyToConsider p Inner Join PolicyActivityHistory pah (Nolock) on pah.PolicyID = p.PolicyID and p.SupplierID = @SupplierID and pah.NewPolicyStatusID = 18

	Select	@TotalChangeRequestedByCarrier = Count(Distinct p.PolicyID) From @PolicyToConsider p Inner Join PolicyActivityHistory pah (Nolock) on pah.PolicyID = p.PolicyID and p.SupplierID = @SupplierID and pah.NewPolicyStatusID = 9
	Select	@TotalChangeRequestedByDistributor = Count(Distinct p.PolicyID) From @PolicyToConsider p Inner Join PolicyActivityHistory pah (Nolock) on pah.PolicyID = p.PolicyID and p.SupplierID = @SupplierID and pah.NewPolicyStatusID = 10
	Select	@TotalChangeRequestedByAgent = Count(Distinct p.PolicyID) From @PolicyToConsider p Inner Join PolicyActivityHistory pah (Nolock) on pah.PolicyID = p.PolicyID and p.SupplierID = @SupplierID and pah.NewPolicyStatusID = 11
	Select	@TotalReissueRequestByAgent = Count(Distinct p.PolicyID) From @PolicyToConsider p Inner Join PolicyActivityHistory pah (Nolock) on pah.PolicyID = p.PolicyID and p.SupplierID = @SupplierID and pah.NewPolicyStatusID = 31


	Select	@WaitingAtDistributor = Count(*) From @PolicyToConsider Where SupplierID = @SupplierID and PolicyStatusID In (3, 6)
	Select	@WaitingAtAgent = Count(*) From @PolicyToConsider Where SupplierID = @SupplierID and PolicyStatusID In (4, 7)

	Select	Distributor = d.Name,
			[Total Sent to Distributor] = (	Select Count(Distinct p.PolicyID) 
											From	@PolicyToConsider p
													Inner Join PolicyDistributor pd (Nolock) on pd.PolicyID = p.PolicyID and pd.DistributionOrder = 1
													Inner Join PolicyActivityHistory pah (Nolock) on pah.PolicyID = p.PolicyID
											Where	p.SupplierID = @SupplierID and pd.DistributorID = pd1.DistributorID and pah.NewPolicyStatusID = 3),
			[Printed By Distributor] = (	Select Count(Distinct p.PolicyID) 
											From	@PolicyToConsider p
													Inner Join PolicyDistributor pd (Nolock) on pd.PolicyID = p.PolicyID and pd.DistributionOrder = 1
													Inner Join PolicyActivityHistory pah (Nolock) on pah.PolicyID = p.PolicyID
											Where	p.SupplierID = @SupplierID and pd.DistributorID = pd1.DistributorID and pah.NewPolicyStatusID = 21),
			[Printed By Agent] = (	Select Count(Distinct p.PolicyID) 
											From	@PolicyToConsider p
													Inner Join PolicyDistributor pd (Nolock) on pd.PolicyID = p.PolicyID and pd.DistributionOrder = 1
													Inner Join PolicyActivityHistory pah (Nolock) on pah.PolicyID = p.PolicyID
											Where	p.SupplierID = @SupplierID and pd.DistributorID = pd1.DistributorID and pah.NewPolicyStatusID = 22),
			[Total Sent to Consumer] = (	Select Count(Distinct p.PolicyID) 
											From	@PolicyToConsider p
													Inner Join PolicyDistributor pd (Nolock) on pd.PolicyID = p.PolicyID and pd.DistributionOrder = 1
													Inner Join PolicyActivityHistory pah (Nolock) on pah.PolicyID = p.PolicyID
											Where	p.SupplierID = @SupplierID and pd.DistributorID = pd1.DistributorID and pah.NewPolicyStatusID = 5),
			[E-Signed] = (	Select Count(Distinct p.PolicyID) 
											From	@PolicyToConsider p
													Inner Join PolicyDistributor pd (Nolock) on pd.PolicyID = p.PolicyID and pd.DistributionOrder = 1
													Inner Join PolicyActivityHistory pah (Nolock) on pah.PolicyID = p.PolicyID
											Where	p.SupplierID = @SupplierID and pd.DistributorID = pd1.DistributorID and pah.NewPolicyStatusID = 24),
			[Declined By Consumer] = (	Select Count(Distinct p.PolicyID) 
											From	@PolicyToConsider p
													Inner Join PolicyDistributor pd (Nolock) on pd.PolicyID = p.PolicyID and pd.DistributionOrder = 1
													Inner Join PolicyActivityHistory pah (Nolock) on pah.PolicyID = p.PolicyID
											Where	p.SupplierID = @SupplierID and pd.DistributorID = pd1.DistributorID and pah.NewPolicyStatusID = 18),
			[Change Requested by Carrier] = (	Select Count(Distinct p.PolicyID) 
											From	@PolicyToConsider p
													Inner Join PolicyDistributor pd (Nolock) on pd.PolicyID = p.PolicyID and pd.DistributionOrder = 1
													Inner Join PolicyActivityHistory pah (Nolock) on pah.PolicyID = p.PolicyID
											Where	p.SupplierID = @SupplierID and pd.DistributorID = pd1.DistributorID and pah.NewPolicyStatusID = 9),
			[Change Requested by Distributor] = (	Select Count(Distinct p.PolicyID) 
											From	@PolicyToConsider p
													Inner Join PolicyDistributor pd (Nolock) on pd.PolicyID = p.PolicyID and pd.DistributionOrder = 1
													Inner Join PolicyActivityHistory pah (Nolock) on pah.PolicyID = p.PolicyID
											Where	p.SupplierID = @SupplierID and pd.DistributorID = pd1.DistributorID and pah.NewPolicyStatusID = 10),
			[Change Requested by Agent] = (	Select Count(Distinct p.PolicyID) 
											From	@PolicyToConsider p
													Inner Join PolicyDistributor pd (Nolock) on pd.PolicyID = p.PolicyID and pd.DistributionOrder = 1
													Inner Join PolicyActivityHistory pah (Nolock) on pah.PolicyID = p.PolicyID
											Where	p.SupplierID = @SupplierID and pd.DistributorID = pd1.DistributorID and pah.NewPolicyStatusID = 11),
			[Reissue Request by Agent] = (	Select Count(Distinct p.PolicyID) 
											From	@PolicyToConsider p
													Inner Join PolicyDistributor pd (Nolock) on pd.PolicyID = p.PolicyID and pd.DistributionOrder = 1
													Inner Join PolicyActivityHistory pah (Nolock) on pah.PolicyID = p.PolicyID
											Where	p.SupplierID = @SupplierID and pd.DistributorID = pd1.DistributorID and pah.NewPolicyStatusID = 31),
			[Avg time elapsed once the policy was sent to the consumer before they accepted] = 
											(Select	COALESCE(Convert(Varchar, (Sum(DATEDIFF(hh, pah1.ActivityDate, pah2.ActivityDate))/Count(*))/24), 'N/A')
											From	@PolicyToConsider p
													Inner Join PolicyActivityHistory pah1 (Nolock) on pah1.PolicyID = p.PolicyID 
																and pah1.PreviousPolicyStatusID <> 5 and pah1.NewPolicyStatusID = 5
													Inner Join PolicyActivityHistory pah2 (Nolock) on pah2.PolicyID = p.PolicyID 
																and pah2.PreviousPolicyStatusID = 5 and pah2.NewPolicyStatusID = 24 and pah2.ActivityDate > pah1.ActivityDate
													Inner Join PolicyDistributor pd (Nolock) on pd.PolicyID = p.PolicyID and pd.DistributionOrder = 1
											Where	p.SupplierID = @SupplierID and pd.DistributorID = pd1.DistributorID),
			[Avg time elapsed once the policy was sent to the consumer before they declined] = 
											(Select	COALESCE(Convert(Varchar, (Sum(DATEDIFF(hh, pah1.ActivityDate, pah2.ActivityDate))/Count(*))/24), 'N/A')
											From	@PolicyToConsider p
													Inner Join PolicyActivityHistory pah1 (Nolock) on pah1.PolicyID = p.PolicyID 
																and pah1.PreviousPolicyStatusID <> 5 and pah1.NewPolicyStatusID = 5
													Inner Join PolicyActivityHistory pah2 (Nolock) on pah2.PolicyID = p.PolicyID 
																and pah2.PreviousPolicyStatusID = 5 and pah2.NewPolicyStatusID = 18 and pah2.ActivityDate > pah1.ActivityDate
													Inner Join PolicyDistributor pd (Nolock) on pd.PolicyID = p.PolicyID and pd.DistributionOrder = 1
											Where	p.SupplierID = @SupplierID and pd.DistributorID = pd1.DistributorID),
			[Avg turn around time after change request] = 
											(Select	COALESCE(Convert(Varchar, (Sum(DATEDIFF(hh, pah1.ActivityDate, pah2.ActivityDate))/Count(*))/24), 'N/A')
											From	@PolicyToConsider p
													Inner Join PolicyActivityHistory pah1 (Nolock) on pah1.PolicyID = p.PolicyID 
																and pah1.PreviousPolicyStatusID Not in (9, 10, 11, 12) and pah1.NewPolicyStatusID in (9, 10, 11, 12)
													Inner Join PolicyActivityHistory pah2 (Nolock) on pah2.PolicyID = p.PolicyID 
																and pah2.PreviousPolicyStatusID in (9, 10, 11, 12) and pah2.NewPolicyStatusID = 3 and pah2.ActivityDate > pah1.ActivityDate
													Inner Join PolicyDistributor pd (Nolock) on pd.PolicyID = p.PolicyID and pd.DistributionOrder = 1
											Where	p.SupplierID = @SupplierID and pd.DistributorID = pd1.DistributorID),
			[Avg time from receipt by Distributor to hand off to Agent] = 
											(Select	COALESCE(Convert(Varchar, (Sum(DATEDIFF(hh, pah1.ActivityDate, pah2.ActivityDate))/Count(*))/24), 'N/A')
											From	@PolicyToConsider p
													Inner Join PolicyActivityHistory pah1 (Nolock) on pah1.PolicyID = p.PolicyID 
																and pah1.PreviousPolicyStatusID Not in (3) and pah1.NewPolicyStatusID in (3)
													Inner Join PolicyActivityHistory pah2 (Nolock) on pah2.PolicyID = p.PolicyID 
																and pah2.PreviousPolicyStatusID in (3, 6) and pah2.NewPolicyStatusID = 4 and pah2.ActivityDate > pah1.ActivityDate
													Inner Join PolicyDistributor pd (Nolock) on pd.PolicyID = p.PolicyID and pd.DistributionOrder = 1
											Where	p.SupplierID = @SupplierID and pd.DistributorID = pd1.DistributorID),
			[Avg time from receipt by Agent to hand off to Consumer] = 
											(Select	COALESCE(Convert(Varchar, (Sum(DATEDIFF(hh, pah1.ActivityDate, pah2.ActivityDate))/Count(*))/24), 'N/A')
											From	@PolicyToConsider p
													Inner Join PolicyActivityHistory pah1 (Nolock) on pah1.PolicyID = p.PolicyID 
																and pah1.PreviousPolicyStatusID Not in (4) and pah1.NewPolicyStatusID in (4)
													Inner Join PolicyActivityHistory pah2 (Nolock) on pah2.PolicyID = p.PolicyID 
																and pah2.PreviousPolicyStatusID in (4, 7) and pah2.NewPolicyStatusID = 5 and pah2.ActivityDate > pah1.ActivityDate
													Inner Join PolicyDistributor pd (Nolock) on pd.PolicyID = p.PolicyID and pd.DistributionOrder = 1
											Where	p.SupplierID = @SupplierID and pd.DistributorID = pd1.DistributorID),
			[Avg time from receipt by Distributor to Consumer signing] = 
											(Select	COALESCE(Convert(Varchar, (Sum(DATEDIFF(hh, pah1.ActivityDate, pah2.ActivityDate))/Count(*))/24), 'N/A')
											From	@PolicyToConsider p
													Inner Join PolicyActivityHistory pah1 (Nolock) on pah1.PolicyID = p.PolicyID 
																and pah1.PreviousPolicyStatusID Not in (3) and pah1.NewPolicyStatusID in (3)
													Inner Join PolicyActivityHistory pah2 (Nolock) on pah2.PolicyID = p.PolicyID 
																and pah2.PreviousPolicyStatusID in (5) and pah2.NewPolicyStatusID = 24 and pah2.ActivityDate > pah1.ActivityDate
													Inner Join PolicyDistributor pd (Nolock) on pd.PolicyID = p.PolicyID and pd.DistributionOrder = 1
											Where	p.SupplierID = @SupplierID and pd.DistributorID = pd1.DistributorID)
	From	@PolicyToConsider p
			Inner Join PolicyDistributor pd1 (Nolock) on pd1.PolicyID = p.PolicyID and pd1.DistributionOrder = 1
			Inner Join Distributor d (Nolock) on d.DistributorID = pd1.DistributorID
	Where	p.SupplierID = @SupplierID
	Group By d.Name, pd1.DistributorID
	Order By d.Name
END
GO
GRANT EXECUTE ON  [dbo].[prc_rpt_PolicyCountAvgTimeBySupplierDistributorStatus] TO [PolicyEXDBReader]
GO
