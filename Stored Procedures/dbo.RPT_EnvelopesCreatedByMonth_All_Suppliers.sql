SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[RPT_EnvelopesCreatedByMonth_All_Suppliers] WITH RECOMPILE
	-- Add the parameters for the stored procedure here

AS
BEGIN
		-- SET NOCOUNT ON added to prevent extra result sets from
		-- interfering with SELECT statements.
		SET NOCOUNT ON;

	Declare	@SupplierId		Int
	declare @Standard table (Month Varchar(500) NULL, MonthInt Int Null, Year Varchar(500) NULL, SupplierID Int NULL, [Policy Count] Int NULL)
	declare @Standard_NY table (Month Varchar(500) NULL, MonthInt Int Null, Year Varchar(500) NULL, SupplierID Int NULL, [Policy Count] Int NULL)
	declare @Lincoln table (Month Varchar(500) NULL, MonthInt Int Null, Year Varchar(500) NULL, SupplierID Int NULL, [Policy Count] Int NULL)
	declare @Hartford table (Month Varchar(500) NULL, MonthInt Int Null, Year Varchar(500) NULL, SupplierID Int NULL, [Policy Count] Int NULL)

	Select	@SupplierId = 206
	Insert	Into @Standard
	SELECT	DateName(mm,DATEADD(mm,MONTH(CreateDate),-1)) as [Month], MONTH(CreateDate) as MonthInt, YEAR(CreateDate) as 'Year', @SupplierId as SupplierID, Count(*) as [Policy Count]
	From	(
				--Policy Edits
				Select	CreateDate = pah.ActivityDate, p.SupplierID
				From	policy p (Nolock)
						Inner Join PolicyActivityHistory pah (Nolock) on pah.PolicyID = p.PolicyID and pah.ActionID = 32
				Where	SupplierID = @SupplierId
				Union ALL
				--Policy Creates
				Select	p.CreateDate, p.SupplierID
				From	policy p (Nolock)
				Where	SupplierID = @SupplierId
			) p
	Group By DateName(mm,DATEADD(mm,MONTH(CreateDate),-1)), MONTH(CreateDate), YEAR(CreateDate)
	Order By YEAR(CreateDate), MONTH(CreateDate)

	Select	@SupplierId = 907
	Insert	Into @Standard_NY
	SELECT	DateName(mm,DATEADD(mm,MONTH(CreateDate),-1)) as [Month], MONTH(CreateDate) as MonthInt, YEAR(CreateDate) as 'Year', @SupplierId as SupplierID, Count(*) as [Policy Count]
	From	(
				--Policy Edits
				Select	CreateDate = pah.ActivityDate, p.SupplierID
				From	policy p (Nolock)
						Inner Join PolicyActivityHistory pah (Nolock) on pah.PolicyID = p.PolicyID and pah.ActionID = 32
				Where	SupplierID = @SupplierId
				Union ALL
				--Policy Creates
				Select	p.CreateDate, p.SupplierID
				From	policy p (Nolock)
				Where	SupplierID = @SupplierId
			) p
	Group By DateName(mm,DATEADD(mm,MONTH(CreateDate),-1)), MONTH(CreateDate), YEAR(CreateDate)
	Order By YEAR(CreateDate), MONTH(CreateDate)

	Select	@SupplierId = 248
	Insert	Into @Lincoln
	SELECT	DateName(mm,DATEADD(mm,MONTH(CreateDate),-1)) as [Month], MONTH(CreateDate) as MonthInt, YEAR(CreateDate) as 'Year', @SupplierId as SupplierID, Count(*) as [Policy Count]
	From	(
				--Policy Edits
				Select	CreateDate = pah.ActivityDate, p.SupplierID
				From	policy p (Nolock)
						Inner Join PolicyActivityHistory pah (Nolock) on pah.PolicyID = p.PolicyID and pah.ActionID = 32
				Where	SupplierID = @SupplierId
				Union ALL
				--Policy Creates
				Select	p.CreateDate, p.SupplierID
				From	policy p (Nolock)
				Where	SupplierID = @SupplierId
			) p
	Group By DateName(mm,DATEADD(mm,MONTH(CreateDate),-1)), MONTH(CreateDate), YEAR(CreateDate)
	Order By YEAR(CreateDate), MONTH(CreateDate)

	Select	@SupplierId = 211
	Insert	Into @Hartford
	SELECT	DateName(mm,DATEADD(mm,MONTH(CreateDate),-1)) as [Month], MONTH(CreateDate) as MonthInt, YEAR(CreateDate) as 'Year', @SupplierId as SupplierID, Count(*) as [Policy Count]
	From	(
				--Policy Edits
				Select	CreateDate = pah.ActivityDate, p.SupplierID
				From	policy p (Nolock)
						Inner Join PolicyActivityHistory pah (Nolock) on pah.PolicyID = p.PolicyID and pah.ActionID = 32
				Where	SupplierID = @SupplierId
				Union ALL
				--Policy Creates
				Select	p.CreateDate, p.SupplierID
				From	policy p (Nolock)
				Where	SupplierID = @SupplierId
			) p
	Group By DateName(mm,DATEADD(mm,MONTH(CreateDate),-1)), MONTH(CreateDate), YEAR(CreateDate)
	Order By YEAR(CreateDate), MONTH(CreateDate)

	Select	[Year] = Coalesce(s.Year, l.Year), [Month] = Coalesce(s.Month, l.Month), [Standard] = ISNULL(s.[Policy Count], 0), [Standard New York] = ISNULL(sny.[Policy Count], 0), [Lincoln] = ISNULL(l.[Policy Count], 0), [Hartford] = ISNULL(h.[Policy Count], 0)
	From	@Standard s
			FULL OUTER JOIN  @Standard_NY sny on sny.Year = s.Year and sny.Month = s.Month
			FULL OUTER JOIN  @Lincoln l on l.Year = s.Year and l.Month = s.Month
			FULL OUTER JOIN  @Hartford h on h.Year = s.Year and h.Month = s.Month
	Order By Coalesce(s.Year, l.Year), Coalesce(s.MonthInt, l.MonthInt)
END

GO
GRANT EXECUTE ON  [dbo].[RPT_EnvelopesCreatedByMonth_All_Suppliers] TO [PolicyEXDBReader]
GO
