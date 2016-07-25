SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[RPT_PolicyCountCreatedByMonth_All_Distributors] WITH RECOMPILE
AS
BEGIN
		  -- SET NOCOUNT ON added to prevent extra result sets from
		  -- interfering with SELECT statements.
		  SET NOCOUNT ON;

	declare @DistributorPolicyCountByMonth table (Month Varchar(500) NULL, MonthInt Int Null, Year Varchar(500) NULL, DistributorID Int NULL, [Policy Count] Int NULL)
	declare     @PolicyDistributors table (DistributorID Int Not Null)
	declare     @PolicySuppliers table (SupplierID  Int Not Null)
	Insert      into @PolicySuppliers Select  248 --Lincoln
	Insert      into @PolicySuppliers Select  206 --Standard
	Insert      into @PolicySuppliers Select  907 --Standard New York

	Declare	@ReportBeginDate	DateTime
	Select	@ReportBeginDate = Convert(Varchar, DATEADD(dd,(-1) * (DATEPART(dd,GETDATE()) - 1) ,DATEADD(mm,-12,GETDATE())), 101)

	Insert      Into @PolicyDistributors 
	Select      Distinct DistributorID 
	From  PolicyDistributor pd
				Inner Join Policy p on p.PolicyID = pd.PolicyID
				Inner Join @PolicySuppliers ps on ps.SupplierID = p.SupplierID
	Where DistributionOrder = 1 and pd.CreateDate >= @ReportBeginDate

	Insert      Into @DistributorPolicyCountByMonth
	SELECT      DateName(mm,DATEADD(mm,MONTH(pd.CreateDate),-1)) as [Month], MONTH(pd.CreateDate) as MonthInt, YEAR(pd.CreateDate) as 'Year', DistributorID, Count(*) as [Policy Count]
	From  PolicyDistributor pd
				Inner Join Policy p on p.PolicyID = pd.PolicyID
				Inner Join @PolicySuppliers ps on ps.SupplierID = p.SupplierID 
	Where DistributionOrder = 1
	Group By DistributorID, DateName(mm,DATEADD(mm,MONTH(pd.CreateDate),-1)), MONTH(pd.CreateDate), YEAR(pd.CreateDate)
	Order By YEAR(pd.CreateDate), MONTH(pd.CreateDate)

	Declare		@Month1Name		Varchar(200)
	Select		@Month1Name = DateName(Month, @ReportBeginDate)

	declare		@TmpTable	Table(Distributor nVarchar(500),
								  Month1		Int,
								  Month2		Int,
								  Month3		Int,
								  Month4		Int,
								  Month5		Int,
								  Month6		Int,
								  Month7		Int,
								  Month8		Int,
								  Month9		Int,
								  Month10		Int,
								  Month11		Int,
								  Month12		Int)
            
	--Insert	Into @TmpTable
	Select      Distributor = d.Name, 
				Month1 = ISNULL(Month1.[Policy Count], 0),
				Month2 = ISNULL(Month2.[Policy Count], 0),
				Month3 = ISNULL(Month3.[Policy Count], 0),
				Month4 = ISNULL(Month4.[Policy Count], 0),
				Month5 = ISNULL(Month5.[Policy Count], 0),
				Month6 = ISNULL(Month6.[Policy Count], 0),
				Month7 = ISNULL(Month7.[Policy Count], 0),
				Month8 = ISNULL(Month8.[Policy Count], 0),
				Month9 = ISNULL(Month9.[Policy Count], 0),
				Month10 = ISNULL(Month10.[Policy Count], 0),
				Month11 = ISNULL(Month11.[Policy Count], 0),
				Month12 = ISNULL(Month12.[Policy Count], 0)
	Into	#TmpTable
	From  @PolicyDistributors pd
				Inner Join Distributor d on d.DistributorID = pd.DistributorID
				Full Outer Join @DistributorPolicyCountByMonth Month1 on Month1.DistributorID = pd.DistributorID and Month1.Year = Year(@ReportBeginDate) and Month1.MonthInt = Month(@ReportBeginDate)
				Full Outer Join @DistributorPolicyCountByMonth Month2 on Month2.DistributorID = pd.DistributorID and Month2.Year = Year(DATEADD(mm, 1, @ReportBeginDate)) and Month2.MonthInt = Month(DATEADD(mm, 1, @ReportBeginDate))
				Full Outer Join @DistributorPolicyCountByMonth Month3 on Month3.DistributorID = pd.DistributorID and Month3.Year = Year(DATEADD(mm, 2, @ReportBeginDate)) and Month3.MonthInt = Month(DATEADD(mm, 2, @ReportBeginDate))
				Full Outer Join @DistributorPolicyCountByMonth Month4 on Month4.DistributorID = pd.DistributorID and Month4.Year = Year(DATEADD(mm, 3, @ReportBeginDate)) and Month4.MonthInt = Month(DATEADD(mm, 3, @ReportBeginDate))
				Full Outer Join @DistributorPolicyCountByMonth Month5 on Month5.DistributorID = pd.DistributorID and Month5.Year = Year(DATEADD(mm, 4, @ReportBeginDate)) and Month5.MonthInt = Month(DATEADD(mm, 4, @ReportBeginDate))
				Full Outer Join @DistributorPolicyCountByMonth Month6 on Month6.DistributorID = pd.DistributorID and Month6.Year = Year(DATEADD(mm, 5, @ReportBeginDate)) and Month6.MonthInt = Month(DATEADD(mm, 5, @ReportBeginDate))
				Full Outer Join @DistributorPolicyCountByMonth Month7 on Month7.DistributorID = pd.DistributorID and Month7.Year = Year(DATEADD(mm, 6, @ReportBeginDate)) and Month7.MonthInt = Month(DATEADD(mm, 6, @ReportBeginDate))
				Full Outer Join @DistributorPolicyCountByMonth Month8 on Month8.DistributorID = pd.DistributorID and Month8.Year = Year(DATEADD(mm, 7, @ReportBeginDate)) and Month8.MonthInt = Month(DATEADD(mm, 7, @ReportBeginDate))
				Full Outer Join @DistributorPolicyCountByMonth Month9 on Month9.DistributorID = pd.DistributorID and Month9.Year = Year(DATEADD(mm, 8, @ReportBeginDate)) and Month9.MonthInt = Month(DATEADD(mm, 8, @ReportBeginDate))
				Full Outer Join @DistributorPolicyCountByMonth Month10 on Month10.DistributorID = pd.DistributorID and Month10.Year = Year(DATEADD(mm, 9, @ReportBeginDate)) and Month10.MonthInt = Month(DATEADD(mm, 9, @ReportBeginDate))
				Full Outer Join @DistributorPolicyCountByMonth Month11 on Month11.DistributorID = pd.DistributorID and Month11.Year = Year(DATEADD(mm, 10, @ReportBeginDate)) and Month11.MonthInt = Month(DATEADD(mm, 10, @ReportBeginDate))
				Full Outer Join @DistributorPolicyCountByMonth Month12 on Month12.DistributorID = pd.DistributorID and Month12.Year = Year(DATEADD(mm, 11, @ReportBeginDate)) and Month12.MonthInt = Month(DATEADD(mm, 11, @ReportBeginDate))
	Where D.DistributorTypeID <> 3 and
				D.CustomerID Not In (1581, 9999) --Exclude iPipeline Test BGAs
	Order By d.Name

	Declare	@RptSQL	nVarchar(Max)
	Select	@RptSQL = 	' Select Distributor, '
						+ '[' + DateName(Month, @ReportBeginDate) + ' ' + Convert(Varchar(4), Year(@ReportBeginDate)) + '] = Month1, '
						+ '[' +  DateName(Month, DATEADD(mm, 1, @ReportBeginDate)) + ' ' + Convert(Varchar(4), Year(DATEADD(mm, 1, @ReportBeginDate))) + '] = Month2, '
						+ '[' +  DateName(Month, DATEADD(mm, 2, @ReportBeginDate)) + ' ' + Convert(Varchar(4), Year(DATEADD(mm, 2, @ReportBeginDate))) + '] = Month3, '
						+ '[' +  DateName(Month, DATEADD(mm, 3, @ReportBeginDate)) + ' ' + Convert(Varchar(4), Year(DATEADD(mm, 3, @ReportBeginDate))) + '] = Month4, '
						+ '[' +  DateName(Month, DATEADD(mm, 4, @ReportBeginDate)) + ' ' + Convert(Varchar(4), Year(DATEADD(mm, 4, @ReportBeginDate))) + '] = Month5, '
						+ '[' +  DateName(Month, DATEADD(mm, 5, @ReportBeginDate)) + ' ' + Convert(Varchar(4), Year(DATEADD(mm, 5, @ReportBeginDate))) + '] = Month6, '
						+ '[' +  DateName(Month, DATEADD(mm, 6, @ReportBeginDate)) + ' ' + Convert(Varchar(4), Year(DATEADD(mm, 6, @ReportBeginDate))) + '] = Month7, '
						+ '[' +  DateName(Month, DATEADD(mm, 7, @ReportBeginDate)) + ' ' + Convert(Varchar(4), Year(DATEADD(mm, 7, @ReportBeginDate))) + '] = Month8, '
						+ '[' +  DateName(Month, DATEADD(mm, 8, @ReportBeginDate)) + ' ' + Convert(Varchar(4), Year(DATEADD(mm, 8, @ReportBeginDate))) + '] = Month9, '
						+ '[' +  DateName(Month, DATEADD(mm, 9, @ReportBeginDate)) + ' ' + Convert(Varchar(4), Year(DATEADD(mm, 9, @ReportBeginDate))) + '] = Month10, '
						+ '[' +  DateName(Month, DATEADD(mm, 10, @ReportBeginDate)) + ' ' + Convert(Varchar(4), Year(DATEADD(mm, 10, @ReportBeginDate))) + '] = Month11, '
						+ '[' +  DateName(Month, DATEADD(mm, 11, @ReportBeginDate)) + ' ' + Convert(Varchar(4), Year(DATEADD(mm, 11, @ReportBeginDate))) + '] = Month12 '
						+ 'From #TmpTable'


	EXEC sp_executesql @RptSQL
	Drop Table #TmpTable
END
GO
GRANT EXECUTE ON  [dbo].[RPT_PolicyCountCreatedByMonth_All_Distributors] TO [PolicyEXDBReader]
GO
