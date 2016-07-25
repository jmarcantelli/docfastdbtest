SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[prc_rpt_BrowserUsageByLoginName]
(
	@LoginName	nvarchar(400)
)
AS
BEGIN
	Declare	@UserID	Int

	Select	@UserID = UserID From [User] (Nolock) Where LoginName = @LoginName

	Declare	@TotalCount	Int
	Select	@TotalCount =	Count(*)
							From	PolicyActivityHistory pah (NoLock)
									Inner Join Policy p (Nolock) on p.PolicyID = pah.PolicyID
							Where	BrowserName is not Null and BrowserName <> ''
									and BrowserPlatform is not Null and BrowserPlatform <> ''
									and pah.UserID = @UserID and pah.ActivityDate >= GETDATE() - 180

	Select	BrowserPlatform as [Operating System], [Device] = COALESCE(MobileDeviceModel, ''), BrowserName as Browser, BrowserVersion as [Version], [No Of Activities] = Count(*),
			[Percent] = Convert(varchar, cast(round((count(*) * 100.0 / sum(count(*)) over()),2) as numeric(36,2))) + '%'
	From	PolicyActivityHistory pah (NoLock)
			Inner Join Policy p (Nolock) on p.PolicyID = pah.PolicyID
	Where	BrowserName is not Null and BrowserName <> ''
			and BrowserPlatform is not Null and BrowserPlatform <> ''
			and pah.UserID = @UserID and pah.ActivityDate >= GETDATE() - 180
	Group By BrowserPlatform, COALESCE(MobileDeviceModel, ''), BrowserName, BrowserVersion
	Order By Count(*) Desc, BrowserName
END
GO
GRANT EXECUTE ON  [dbo].[prc_rpt_BrowserUsageByLoginName] TO [PolicyEXDBReader]
GO
