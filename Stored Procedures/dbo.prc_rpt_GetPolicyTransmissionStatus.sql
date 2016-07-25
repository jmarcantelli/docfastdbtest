SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[prc_rpt_GetPolicyTransmissionStatus]

(
	@SupplierID		Int,
	@StartDate		Varchar(10),
	@EndDate		Varchar(10)
)
AS
Begin
	Select	Distinct [Policy] = p.PolNumber, [Transmission Status] = tms.Description, [Added Date Time] = tm.AddedDateTime, [Last Response] = COALESCE(tm.LastResponse, '')
	From	Policy p (Nolock)
			Inner Join PolicyTransmission.dbo.tblTransmissionManager tm (Nolock) on tm.OwnerUserID = p.TransmissionOwnerUserID
			Inner Join PolicyTransmission.dbo.tblTransmissionManagerStatus tms (Nolock) on tms.Status = tm.Status
	Where	p.SupplierID = @SupplierID
			and p.PolicyStatusID = 24
			and tm.AddedDateTime >= @StartDate
			and tm.AddedDateTime <= @EndDate
	Order By tm.AddedDateTime Desc
END
GO
GRANT EXECUTE ON  [dbo].[prc_rpt_GetPolicyTransmissionStatus] TO [PolicyEXDBReader]
GO
