SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[RPT_GetPolicyCountBySubmitCompletePrint_TimeRange_Monthly]
(
	@SupplierID		Int,
	@StartDate	DateTime,
	@EndDate DateTime
)
AS
BEGIN
select AllMonthsInSelectedRange.[AllMonths] as [Month],
coalesce(resultForSubmitted.Submitted,0) as [Submitted],
coalesce(resultForCompleted.[Completed],0) as [Completed],
coalesce(resultForPrinted.[Printed],0) as [Printed],
convert(varchar(10),coalesce(convert(decimal(5,2),(((coalesce(resultForCompleted.[Completed],0)+coalesce(resultForPrinted.[Printed],0))*100.0)/nullif(resultForSubmitted.Submitted,0))),0))+'%' as Percentage
from
(select  DATENAME(MONTH, DateId) + ', ' + DATENAME(YEAR, DateId) as [AllMonths]
from CalendarFrom1900To2099 (NOLOCK)
where DateId >= @StartDate
and DateId <= @EndDate
group by DATENAME(MONTH, DateId) + ', ' + DATENAME(YEAR, DateId)
)AllMonthsInSelectedRange
left outer join
(
  SELECT DATENAME(MONTH, ActivityDate) + ', ' + DATENAME(YEAR, ActivityDate) as [SubmittedMonths] ,count(*) as [Submitted]
  FROM PolicyActivityHistory pah (NOLOCK)
  inner join policy p (NOLOCK) on p.PolicyID=pah.PolicyID
  where PreviousPolicyStatusID IS NULL and NewPolicyStatusID in (3,4,5)
  and pah.ActivityDate>= @StartDate
and pah.ActivityDate <= @EndDate
and p.SupplierID=@SupplierID
  group by DATENAME(MONTH, ActivityDate) + ', ' + DATENAME(YEAR, ActivityDate)
) resultForSubmitted on AllMonthsInSelectedRange.[AllMonths]=resultForSubmitted.[SubmittedMonths]
left outer join 
(
  SELECT DATENAME(MONTH, ActivityDate) + ', ' + DATENAME(YEAR, ActivityDate) as [CompletedMonth] ,count(*) as [Completed]
  FROM PolicyActivityHistory pah (NOLOCK)
  inner join policy p (NOLOCK) on p.PolicyID=pah.PolicyID
  where NewPolicyStatusID=24 and PreviousPolicyStatusID <>NewPolicyStatusID
   and pah.ActivityDate>= @StartDate
and pah.ActivityDate <= @EndDate
and p.SupplierID=@SupplierID
  group by DATENAME(MONTH, ActivityDate) + ', ' + DATENAME(YEAR, ActivityDate)
) resultForCompleted on AllMonthsInSelectedRange.[AllMonths]=resultForCompleted.[CompletedMonth]
left outer join 
(
  SELECT DATENAME(MONTH, ActivityDate) + ', ' + DATENAME(YEAR, ActivityDate) as [PrintedMonth] ,count(*) as [Printed]
  FROM PolicyActivityHistory pah (NOLOCK)
  inner join policy p (NOLOCK) on p.PolicyID=pah.PolicyID
 where NewPolicyStatusID in (21,22,23,27) and PreviousPolicyStatusID <>NewPolicyStatusID
   and pah.ActivityDate>= @StartDate
and pah.ActivityDate <= @EndDate
and p.SupplierID=@SupplierID
  group by DATENAME(MONTH, ActivityDate) + ', ' + DATENAME(YEAR, ActivityDate)
) resultForPrinted on AllMonthsInSelectedRange.[AllMonths]=resultForPrinted.[PrintedMonth]
order by convert(date,AllMonthsInSelectedRange.[AllMonths],101)
END
GO
GRANT EXECUTE ON  [dbo].[RPT_GetPolicyCountBySubmitCompletePrint_TimeRange_Monthly] TO [PolicyEXDBReader]
GO
