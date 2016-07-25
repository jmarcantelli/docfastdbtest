SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[RPT_GetPolicyCountBySubmitCompletePrint_TimeRange_Daily]
(
	@SupplierID		Int,
	@StartDate	DateTime,
	@EndDate DateTime
)
AS
BEGIN
set @EndDate=DATEADD(dd,1,@EndDate)
select allDatesInSelectedRange.[AllDates] as Date,
coalesce(resultForSubmitted.Submitted,0) as [Submitted],
coalesce(SUM([Submitted])OVER(ORDER BY allDatesInSelectedRange.[AllDates] ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW),0) AS [Total Submitted],
coalesce(resultForCompleted.[Completed],0) as [Completed],
coalesce(SUM([Completed])OVER(ORDER BY allDatesInSelectedRange.[AllDates] ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW),0) AS [Total Completed],
coalesce(resultForPrinted.[Printed],0) as [Printed],
coalesce(SUM([Printed])OVER(ORDER BY allDatesInSelectedRange.[AllDates] ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW),0) AS [Total Printed]
from
(select distinct CONVERT(VARCHAR(10), DateId,101) as [AllDates]
from CalendarFrom1900To2099 (NOLOCK)
where DateId >= @StartDate
and DateId < @EndDate)allDatesInSelectedRange
left outer join
(
SELECT CONVERT(VARCHAR(10), pah.ActivityDate,101) as [SubmittedDates] ,count(*) as [Submitted]
	  FROM PolicyActivityHistory pah (NOLOCK)
	  inner join policy p (NOLOCK) on p.PolicyID=pah.PolicyID
	  where PreviousPolicyStatusID IS NULL and NewPolicyStatusID in (3,4,5)
	  and pah.ActivityDate>= @StartDate
and pah.ActivityDate < @EndDate
and p.SupplierID=@SupplierID
	  group by CONVERT(VARCHAR(10), pah.ActivityDate,101)
)resultForSubmitted on allDatesInSelectedRange.[AllDates]=resultForSubmitted.[SubmittedDates]
left outer join 
	(
		SELECT CONVERT(VARCHAR(10), pah.ActivityDate,101) as [CompletedDates] ,count(*) as [Completed]
		FROM PolicyActivityHistory pah (NOLOCK)
		inner join policy p (NOLOCK) on p.PolicyID=pah.PolicyID
		where NewPolicyStatusID=24 and PreviousPolicyStatusID <>NewPolicyStatusID
		 and pah.ActivityDate>= @StartDate
and pah.ActivityDate < @EndDate
and p.SupplierID=@SupplierID
		group by CONVERT(VARCHAR(10), pah.ActivityDate,101)
	) resultForCompleted on allDatesInSelectedRange.[AllDates]=resultForCompleted.[CompletedDates]
left outer join
	(
	SELECT CONVERT(VARCHAR(10), pah.ActivityDate,101) as [PrintedDates] ,count(*) as [Printed]
		FROM PolicyActivityHistory pah (NOLOCK)
		inner join policy p (NOLOCK) on p.PolicyID=pah.PolicyID
		where NewPolicyStatusID in (21,22,23,27) and PreviousPolicyStatusID <>NewPolicyStatusID
		 and pah.ActivityDate>= @StartDate
and pah.ActivityDate < @EndDate
and p.SupplierID=@SupplierID
		group by CONVERT(VARCHAR(10), pah.ActivityDate,101)
	)resultForPrinted on allDatesInSelectedRange.[AllDates]=resultForPrinted.[PrintedDates]
order by allDatesInSelectedRange.AllDates
END
GO
GRANT EXECUTE ON  [dbo].[RPT_GetPolicyCountBySubmitCompletePrint_TimeRange_Daily] TO [PolicyEXDBReader]
GO
