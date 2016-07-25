SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[prc_rpt_GetConsumerPortalBrowserUsage]
AS
BEGIN
	Declare	@TotalCount	Int
	Select	@TotalCount =	Count(*)
							From	PolicyActivityHistory pah (NoLock)
									Inner Join Policy p (Nolock) on p.PolicyID = pah.PolicyID
							Where	p.SupplierID <> 265 and BrowserName is not Null and BrowserName <> ''
									and pah.ConsumerRecipientID is Not Null and pah.ActivityDate >= GETDATE() - 180

	Select	BrowserName as Browser, BrowserVersion as [Version], [No Of Activities] = Count(*),
			[Percent] = Convert(varchar, cast(round((count(*) * 100.0 / sum(count(*)) over()),2) as numeric(36,2))) + '%'
	From	PolicyActivityHistory pah (NoLock)
			Inner Join Policy p (Nolock) on p.PolicyID = pah.PolicyID
	Where	p.SupplierID <> 265 and BrowserName is not Null and BrowserName <> ''
			and pah.ConsumerRecipientID is Not Null and pah.ActivityDate >= GETDATE() - 180
	Group By BrowserName, BrowserVersion
	Order By Count(*) Desc, BrowserName
END
GO
GRANT EXECUTE ON  [dbo].[prc_rpt_GetConsumerPortalBrowserUsage] TO [PolicyEXDBReader]
GO
