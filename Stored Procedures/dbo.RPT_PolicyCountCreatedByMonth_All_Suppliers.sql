SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[RPT_PolicyCountCreatedByMonth_All_Suppliers] WITH RECOMPILE
	-- Add the parameters for the stored procedure here

AS
BEGIN
	Declare	@Sql	nVarchar(Max)
	Declare	@SupplierNames	Varchar(Max)
	Declare	@ColNames	Varchar(Max)
	Declare	@FirstSupplierName	Varchar(500)

	Declare	@SupplierNamesTable Table (SupplierName Varchar(500))

	--Get the list of all supplier names that have at least one policy
	Insert Into @SupplierNamesTable
	Select	COALESCE(si.SupplierName, si.Description) 
	From	SupplierIdentifier si (Nolock)
			Inner Join Policy p (Nolock) on p.SupplierID = si.SupplierID
	Group By COALESCE(si.SupplierName, si.Description)
	Having Count(*) > 0
	Order By COALESCE(si.SupplierName, si.Description)

	--Get The Supplier Names concatenated, used in the PIVOT query below
	Select	@SupplierNames = COALESCE(@SupplierNames + '], [', '') + SupplierName 
	From	@SupplierNamesTable
	Order By SupplierName
	Select	@SupplierNames = '[' + @SupplierNames + ']'

	--Get the list of supplier names for column names, in the select query
	Select	Top 1 @FirstSupplierName = SupplierName From @SupplierNamesTable Order By SupplierName
	Select	@ColNames =  COALESCE(@ColNames + ']' +  ', '  + Char(39) + Char(39) + ')' + ', [' + SupplierName + '] = ' + 'COALESCE(' + '[', '') + SupplierName
	From	@SupplierNamesTable
	Order By SupplierName
	Select	@ColNames = '[' + @FirstSupplierName + '] = ' + 'COALESCE(' + '[' + @ColNames + ']' + ', ' +  Char(39) + Char(39) + ')'


	Select	@Sql =	'SELECT	Year, Month, ' + @ColNames
					+ ' FROM ('
					+ '		SELECT	SupplierName = COALESCE(si.SupplierName, si.Description),'
					+ '				[Year] = YEAR(p.CreateDate),'
					+ '				[Month] = DateName(mm,DATEADD(mm,MONTH(p.CreateDate),-1)),'
					+ '				[MonthInt] = MONTH(p.CreateDate),'
					+ '				[Policy Count] = Count(*)'
					+ '		From	policy p (Nolock)'
					+ '				Inner Join SupplierIdentifier si (Nolock) on si.SupplierID = p.SupplierID'
					+ '		Group By p.SupplierID, COALESCE(si.SupplierName, si.Description), DateName(mm,DATEADD(mm,MONTH(p.CreateDate),-1)), MONTH(p.CreateDate), YEAR(p.CreateDate)'
					+ ' ) as s'
					+ ' PIVOT'
					+ ' ('
					+ '	SUM([Policy Count])'
					+ '	FOR [SupplierName] IN (' + @SupplierNames + ')'
					+ ' ) AS pvt'
					+ ' Order By [Year] Desc, MonthInt Desc'

	Execute(@Sql)
END
GO
GRANT EXECUTE ON  [dbo].[RPT_PolicyCountCreatedByMonth_All_Suppliers] TO [PolicyEXDBReader]
GO
