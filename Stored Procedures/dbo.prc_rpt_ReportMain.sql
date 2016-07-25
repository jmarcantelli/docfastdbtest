SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[prc_rpt_ReportMain]
(
	@ReportId			int,
	@ReportParamList	Varchar(Max)
)
AS
BEGIN
	Declare	@PolNumber	Varchar(250)
	Declare	@SupplierID	Int
	Declare	@DistributorID	Int
	Declare	@LoginName	nvarchar(400)
	Declare	@EmailAddress	nvarchar(1000)
	Declare	@StartDate	Varchar(10)
	Declare	@EndDate	Varchar(10)

	DECLARE @ParamNameVal varchar(100)
	DECLARE @StartPos int
	Declare	@Length int
	DECLARE @Delimeter char(1)
	DECLARE @ParamName varchar(100)
	SET @Delimeter = '|'

	WHILE LEN(@ReportParamList) > 0
	BEGIN
		SET @StartPos = CHARINDEX(@Delimeter, @ReportParamList)
		IF @StartPos < 0 SET @StartPos = 0
		SET @Length = LEN(@ReportParamList) - @StartPos - 1
		IF @Length < 0 SET @Length = 0

		IF @StartPos > 0
		BEGIN
			SET @ParamNameVal = SUBSTRING(@ReportParamList, 1, @StartPos - 1)
			SET @ReportParamList = SUBSTRING(@ReportParamList, @StartPos + 1, LEN(@ReportParamList) - @StartPos)
		END
		ELSE
		BEGIN
			SET @ParamNameVal = @ReportParamList
			SET @ReportParamList = ''
		END

		Set	@ParamName = SUBSTRING(@ParamNameVal, 1, CHARINDEX('=', @ParamNameVal) - 1)

		IF @ParamName = '@PolNumber'
		Begin
			set	@PolNumber = Substring(@ParamNameVal, CHARINDEX('=', @ParamNameVal) + 1, Len(@ParamNameVal) - CHARINDEX('=', @ParamNameVal))
			Print @PolNumber
		End
		Else If @ParamName = '@SupplierID'
		Begin
			set	@SupplierID = Convert(Int, Substring(@ParamNameVal, CHARINDEX('=', @ParamNameVal) + 1, Len(@ParamNameVal) - CHARINDEX('=', @ParamNameVal)))
		End
		Else If @ParamName = '@DistributorID'
		Begin
			set	@DistributorID = Convert(Int, Substring(@ParamNameVal, CHARINDEX('=', @ParamNameVal) + 1, Len(@ParamNameVal) - CHARINDEX('=', @ParamNameVal)))
		End
		Else If @ParamName = '@LoginName'
		Begin
			set	@LoginName = Substring(@ParamNameVal, CHARINDEX('=', @ParamNameVal) + 1, Len(@ParamNameVal) - CHARINDEX('=', @ParamNameVal))
		End
		Else If @ParamName = '@EmailAddress'
		Begin
			set	@EmailAddress = Substring(@ParamNameVal, CHARINDEX('=', @ParamNameVal) + 1, Len(@ParamNameVal) - CHARINDEX('=', @ParamNameVal))
		End
		Else If @ParamName = '@StartDate'
		Begin
			set	@StartDate = Substring(@ParamNameVal, CHARINDEX('=', @ParamNameVal) + 1, Len(@ParamNameVal) - CHARINDEX('=', @ParamNameVal))
		End
		Else If @ParamName = '@EndDate'
		Begin
			set	@EndDate = Substring(@ParamNameVal, CHARINDEX('=', @ParamNameVal) + 1, Len(@ParamNameVal) - CHARINDEX('=', @ParamNameVal))
		End
	END

	If @ReportId = 1	--Policy Approvers
		Execute	prc_rpt_GetPolicyApproverList @PolNumber, @SupplierID
	Else If @ReportId = 2	--Policies Created Today
		Execute	prc_rpt_GetPolicyCreatedToday @SupplierID
	Else If @ReportId = 3	--DocuSign Templates Applied on Policy
		Execute	prc_rpt_GetDocuSignTemplatesOnPolicy @PolNumber, @SupplierID
	Else If @ReportId = 4	--Supplier Distributor Mapping
		Execute	prc_rpt_GetSupplierDistributorMapping @SupplierID
	Else If @ReportId = 5	--Supplier Configurations
		Execute	prc_rpt_GetSupplierConfigurations @SupplierID
	Else If @ReportId = 6	--Distributor Configurations
		Execute	prc_rpt_GetDistributorConfigurations @DistributorID
	Else If @ReportId = 7	--Browser Usage - Partner Portal
		Execute	prc_rpt_GetPartnerPortalBrowserUsage
	Else If @ReportId = 8	--Browser Usage - Consumer Portal
		Execute	prc_rpt_GetConsumerPortalBrowserUsage
	Else If @ReportId = 9	--Policies Assigned By Login
		Execute	prc_rpt_GetPoliciesAssignedByLogin @LoginName
	Else If @ReportId = 10	--Policy Activity History
		Execute	prc_rpt_GetPolicyActivity @PolNumber, @SupplierID
	Else If @ReportId = 11	--List of Logins by Email
		Execute	prc_rpt_GetLoginsByEmailAddress @EmailAddress
	Else If @ReportId = 12	--List of users by Supplier
		Execute	prc_rpt_GetUsersBySupplier @SupplierID
	Else If @ReportId = 13	--List of users by Distributor
		Execute	prc_rpt_GetUsersByDistributor @DistributorID
	Else If @ReportId = 14	--List of users mapped to a Supplier
		Execute	prc_rpt_GetUsersMappedToSupplier @SupplierID
	Else If @ReportId = 15	--SubGAs By Suppliern
		Execute	prc_rpt_GetSubGAs @SupplierID
	Else If @ReportId = 16	--Face To face Usage by Supplier
		Execute	prc_rpt_GetFaceToFaceUsageBySupplier @SupplierID
	Else If @ReportId = 17	--Policy Count by Supplier
		Execute	RPT_PolicyCountCreatedByMonth_All_Suppliers
	Else If @ReportId = 18	--Policy Count by Distributor
		Execute	RPT_PolicyCountCreatedByMonth_All_Distributors
	Else If @ReportId = 19	--Policy Count by Distributor By Supplier
		Execute	prc_rpt_PolicyCountCreatedByMonth_All_DistributorsBySupplier @SupplierID
	Else If @ReportId = 20	--Envelope Count by Supplier
		Execute	RPT_EnvelopesCreatedByMonth_All_Suppliers
	Else If @ReportId = 21	--Policy Stat By Supplier Distributor
		Execute	prc_rpt_GetPolicyStatBySupplierDistributor @SupplierID, @StartDate, @EndDate
    Else If @ReportId = 22	--Browser Usage By Login Name
		    Execute	prc_rpt_BrowserUsageByLoginName @LoginName
	Else If @ReportId = 23	--Composite Internal Report 
		    Execute	RPT_GetAllPoliciesBySupplierId @SupplierID, @StartDate, @EndDate
	Else If @ReportId = 24	--Elapsed Time for all policies
		    Execute	RPT_GetAllPoliciesElapsedTimeBySupplierId @SupplierID, @StartDate, @EndDate
	Else If @ReportId = 25	--Policy Count By Status
		    Execute	RPT_GetPolicyCountByStatusBySupplierId @SupplierID, @StartDate, @EndDate
	Else If @ReportId = 26	--Policy Count By Status Horizontal Data 
		    Execute	RPT_GetPolicyCountByStatusBySupplierId_HorizontalData @SupplierID, @StartDate, @EndDate
	Else If @ReportId = 27	--Policy Count By Status for a Time Range
		    Execute	RPT_GetPolicyCountByStatusBySupplierId_TimeRange @SupplierID, @StartDate, @EndDate
	Else If @ReportId = 28	--Policy Count By Submit Complete Print TimeRange Daily interval
		    Execute	RPT_GetPolicyCountBySubmitCompletePrint_TimeRange_Daily @SupplierID, @StartDate, @EndDate
	Else If @ReportId = 29	--Policy Count By Submit Complete Print_TimeRange Monthly interval
		    Execute	RPT_GetPolicyCountBySubmitCompletePrint_TimeRange_Monthly @SupplierID, @StartDate, @EndDate
	Else If @ReportId = 30	--Policy Count By InProcess Complete Print For Distributors
		    Execute	RPT_GetAllPoliciesCountByInProcessCompletePrintForDistributors @SupplierID, @StartDate, @EndDate
	Else If @ReportId = 31	--Policy Count By InProcess Complete Print For DirectWriters
		    Execute	RPT_GetAllPoliciesCountByInProcessCompletePrintForDirectWriters @SupplierID, @StartDate, @EndDate
	Else If @ReportId = 32	--Policy Count By Status For Distributors And DirectWriters
		    Execute	RPT_GetAllPoliciesCountByStatusForDistributorsAndDirectWriters @SupplierID, @StartDate, @EndDate
	Else If @ReportId = 33	--Policy Count Average Time By Supplier Distributor Status
		    Execute	prc_rpt_PolicyCountAvgTimeBySupplierDistributorStatus @SupplierID, @StartDate, @EndDate
	Else If @ReportId = 34	--Policy Transmission Status
		    Execute	prc_rpt_GetPolicyTransmissionStatus @SupplierID, @StartDate, @EndDate
END
GO
GRANT EXECUTE ON  [dbo].[prc_rpt_ReportMain] TO [PolicyEXDBReader]
GO
