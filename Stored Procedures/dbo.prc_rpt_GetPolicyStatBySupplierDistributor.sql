SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[prc_rpt_GetPolicyStatBySupplierDistributor]

(
	@SupplierID		Int,
	@StartDate		Varchar(10),
	@EndDate		Varchar(10)
)
AS
BEGIN
	Select	Distributor = d.Name,
			pd.[Policy Count],
			[e-Signed] = Coalesce(pe.[No of Policies e-Signed by Consumer], 0),
			Printed = Coalesce(pp.Printed, 0),
			Declined = Coalesce(pdec.Declined, 0),
			[Distributor Avg Days] = Coalesce(davg.[Distributor Avg Days], 'N/A'),
			[Agent Avg Days] = Coalesce(aavg.[Agent Avg Days], 'N/A'),
			[Consumer Avg Days] = Coalesce([Consumer Avg Days], 'N/A')
	From	(
				Select	DistributorId, [Policy Count] = Convert(Varchar, Count(*))
				From	PolicyDistributor pd (Nolock)
						Inner Join Policy p (Nolock) on p.PolicyID = pd.PolicyID and pd.DistributionOrder = 1
				Where	p.SupplierID = @SupplierID
						and p.CreateDate >= @StartDate and p.CreateDate <= @EndDate
				Group By pd.DistributorID
			) pd
			Left Outer Join	(
							Select	DistributorId,
									[Distributor Avg Days] = Convert(Varchar, (Sum([Hours to Complete])/Count(*))/24)
							From	(	Select	pd.DistributorID,
												[Hours to Complete] = DATEDIFF(hh, P.CreateDate, pah.ActivityDate)
										From	Policy p (Nolock)
												Inner Join PolicyActivityHistory pah (Nolock) on pah.PolicyID = p.PolicyID
												Inner Join PolicyDistributor pd (Nolock) on pd.PolicyID = p.PolicyID and pd.DistributionOrder = 1
										Where	p.SupplierID = @SupplierID
												and (
														(pah.PreviousPolicyStatusID = 3 and pah.NewPolicyStatusID not in(3, 6)) Or
														(pah.PreviousPolicyStatusID = 6 and pah.NewPolicyStatusID not in(3, 6))
													)
									) p
							Group By DistributorId
						) davg on davg.DistributorID = pd.DistributorID
			Left Outer Join	(
					Select	DistributorId,
							[Agent Avg Days] = Convert(Varchar, (Sum([Hours to Complete])/Count(*))/24)
					From	(	Select	pd.DistributorID,
										[Hours to Complete] = DATEDIFF(hh, P.CreateDate, pah.ActivityDate)
								From	Policy p (Nolock)
										Inner Join PolicyActivityHistory pah (Nolock) on pah.PolicyID = p.PolicyID
										Inner Join PolicyDistributor pd (Nolock) on pd.PolicyID = p.PolicyID and pd.DistributionOrder = 1
								Where	p.SupplierID = @SupplierID
										and (
												(pah.PreviousPolicyStatusID = 4 and pah.NewPolicyStatusID not in(4, 7)) Or
												(pah.PreviousPolicyStatusID = 7 and pah.NewPolicyStatusID not in(4, 7))
											)
							) p
					Group By DistributorId
				) aavg on pd.DistributorID = aavg.DistributorID
			Left Outer Join	(
					Select	DistributorId,
							[Consumer Avg Days] = Convert(Varchar, (Sum([Hours to Complete])/Count(*))/24)
					From	(	Select	pd.DistributorID,
										[Hours to Complete] = DATEDIFF(hh, P.CreateDate, pah.ActivityDate)
								From	Policy p (Nolock)
										Inner Join PolicyActivityHistory pah (Nolock) on pah.PolicyID = p.PolicyID
										Inner Join PolicyDistributor pd (Nolock) on pd.PolicyID = p.PolicyID and pd.DistributionOrder = 1
								Where	p.SupplierID = @SupplierID
										and (
												(pah.PreviousPolicyStatusID = 5 and pah.NewPolicyStatusID not in(5, 8)) Or
												(pah.PreviousPolicyStatusID = 8 and pah.NewPolicyStatusID not in(5, 8))
											)
							) p
					Group By DistributorId
				) cavg on pd.DistributorID = cavg.DistributorID
			Left Outer Join (
					Select	DistributorId, [No of Policies e-Signed by Consumer] = COALESCE(Count(*), 0)
					From	PolicyDistributor pd (Nolock)
							Inner Join Policy p (Nolock) on p.PolicyID = pd.PolicyID and pd.DistributionOrder = 1
					Where	p.SupplierID = @SupplierID
							and p.CreateDate >= @StartDate and p.CreateDate <= @EndDate
							and p.PolicyStatusID = 24
					Group By pd.DistributorID
				) pe on pd.DistributorID = pe.DistributorID
			Left Outer Join (
					Select	DistributorId, [Printed] = COALESCE(Count(*), 0)
					From	PolicyDistributor pd (Nolock)
							Inner Join Policy p (Nolock) on p.PolicyID = pd.PolicyID and pd.DistributionOrder = 1
					Where	p.SupplierID = @SupplierID
							and p.CreateDate >= @StartDate and p.CreateDate <= @EndDate
							and p.PolicyStatusID in (21, 22, 23, 27)
					Group By pd.DistributorID
				) pp on pd.DistributorID = pp.DistributorID
		Left Outer Join (
					Select	DistributorId, [Declined] = COALESCE(Count(*), 0)
					From	PolicyDistributor pd (Nolock)
							Inner Join Policy p (Nolock) on p.PolicyID = pd.PolicyID and pd.DistributionOrder = 1
					Where	p.SupplierID = @SupplierID
							and p.CreateDate >= @StartDate and p.CreateDate <= @EndDate
							and p.PolicyStatusID in (15, 16, 17, 18, 19, 20)
					Group By pd.DistributorID
				) pdec on pd.DistributorID = pdec.DistributorID
		Inner Join Distributor d (Nolock) on d.DistributorID = pd.DistributorID
	Order By d.Name
END
GO
GRANT EXECUTE ON  [dbo].[prc_rpt_GetPolicyStatBySupplierDistributor] TO [PolicyEXDBReader]
GO
