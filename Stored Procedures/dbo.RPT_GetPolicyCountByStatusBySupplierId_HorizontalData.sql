SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[RPT_GetPolicyCountByStatusBySupplierId_HorizontalData]
(
	@SupplierID		Int,
	@StartDate	DateTime,
	@EndDate DateTime
)
AS
BEGIN
select [Supplier Name],
coalesce([Incomplete],0)[Incomplete],
coalesce([Pending Delivery],0)[Pending Delivery],
coalesce([Sent to Distributor],0)[Sent to Distributor],
coalesce([Sent to Agent],0)[Sent to Agent],
coalesce([Sent to Consumer],0)[Sent to Consumer],
coalesce([Received by Distributor],0)[Received by Distributor],
coalesce([Received by Agent],0)[Received by Agent],
coalesce([Received by Consumer],0)[Received by Consumer],
coalesce([Change Requested by Carrier],0)[Change Requested by Carrier],
coalesce([Change Requested by Distributor],0)[Change Requested by Distributor],
coalesce([Change Requested by Agent],0)[Change Requested by Agent],
coalesce([Change Requested by Consumer],0)[Change Requested by Consumer],
coalesce([Change Forwarded by Distributor],0)[Change Forwarded by Distributor],
coalesce([Change Forwarded by Agent],0)[Change Forwarded by Agent],
coalesce([Declined Offer by Carrier (NTO)],0)[Declined Offer by Carrier (NTO)],
coalesce([Declined Offer by Distributor (NTO)],0)[Declined Offer by Distributor (NTO)],
coalesce([Declined Offer by Agent (NTO)],0)[Declined Offer by Agent (NTO)],
coalesce([Declined Offer by Consumer (NTO)],0)[Declined Offer by Consumer (NTO)],
coalesce([Declined Offer Forwarded by Agent (NTO)],0)[Declined Offer Forwarded by Agent (NTO)],
coalesce([Declined Offer Forwarded by Distributor (NTO)],0)[Declined Offer Forwarded by Distributor (NTO)],
coalesce([Printed for Paper Delivery by Distributor],0)[Printed for Paper Delivery by Distributor],
coalesce([Printed for Paper Delivery by Agent],0)[Printed for Paper Delivery by Agent],
coalesce([Printed for Paper Delivery by Consumer],0)[Printed for Paper Delivery by Consumer],
coalesce([Delivery Requirements Received],0)[Delivery Requirements Received],
coalesce([Deleted],0)[Deleted],
coalesce([Consumer Opted Out of Electronic Delivery],0)[Consumer Opted Out of Electronic Delivery],
coalesce([Printed for Paper Delivery by Carrier],0)[Printed for Paper Delivery by Carrier],
coalesce([Consumer Policy Suspended ],0)[Consumer Policy Suspended ],
coalesce([Consumer Failed ID Check],0)[Consumer Failed ID Check],
coalesce([Consumer Failed Login],0)[Consumer Failed Login],
coalesce([Reissue Request by Agent],0)[Reissue Request by Agent],
coalesce([Expired],0)[Expired],
(coalesce([Incomplete],0)+
coalesce([Pending Delivery],0)+
coalesce([Sent to Distributor],0)+
coalesce([Sent to Agent],0)+
coalesce([Sent to Consumer],0)+
coalesce([Received by Distributor],0)+
coalesce([Received by Agent],0)+
coalesce([Received by Consumer],0)+
coalesce([Change Requested by Carrier],0)+
coalesce([Change Requested by Distributor],0)+
coalesce([Change Requested by Agent],0)+
coalesce([Change Requested by Consumer],0)+
coalesce([Change Forwarded by Distributor],0)+
coalesce([Change Forwarded by Agent],0)+
coalesce([Declined Offer by Carrier (NTO)],0)+
coalesce([Declined Offer by Distributor (NTO)],0)+
coalesce([Declined Offer by Agent (NTO)],0)+
coalesce([Declined Offer by Consumer (NTO)],0)+
coalesce([Declined Offer Forwarded by Agent (NTO)],0)+
coalesce([Declined Offer Forwarded by Distributor (NTO)],0)+
coalesce([Printed for Paper Delivery by Distributor],0)+
coalesce([Printed for Paper Delivery by Agent],0)+
coalesce([Printed for Paper Delivery by Consumer],0)+
coalesce([Delivery Requirements Received],0)+
coalesce([Deleted],0)+
coalesce([Consumer Opted Out of Electronic Delivery],0)+
coalesce([Printed for Paper Delivery by Carrier],0)+
coalesce([Consumer Policy Suspended ],0)+
coalesce([Consumer Failed ID Check],0)+
coalesce([Consumer Failed Login],0)+
coalesce([Reissue Request by Agent],0)+
coalesce([Expired],0)) as[Total]
from 
(
select 
		[Supplier Name]=COALESCE(si.SupplierName,''),
		[Status]= result.Status,
		[Policy Count] 
from(
Select	
		SupplierId, 
		ps.PolicyStatusName as [Status], 
		Count(*) as [Policy Count]
From	Policy p (NOLOCK)
		inner Join PolicyStatus ps (NOLOCK) on ps.PolicyStatusID = p.PolicyStatusID
Where	SupplierID = @SupplierID
AND p.CreateDate >= @StartDate
AND p.CreateDate <= @EndDate
Group By SupplierId, ps.PolicyStatusName
)result
LEFT OUTER join SupplierIdentifier si (NOLOCK) on si.SupplierID=result.SupplierID
)d
pivot
(
max([Policy Count] )
for 
[Status] in (
[Incomplete],
[Pending Delivery],
[Sent to Distributor],
[Sent to Agent],
[Sent to Consumer],
[Received by Distributor],
[Received by Agent],
[Received by Consumer],
[Change Requested by Carrier],
[Change Requested by Distributor],
[Change Requested by Agent],
[Change Requested by Consumer],
[Change Forwarded by Distributor],
[Change Forwarded by Agent],
[Declined Offer by Carrier (NTO)],
[Declined Offer by Distributor (NTO)],
[Declined Offer by Agent (NTO)],
[Declined Offer by Consumer (NTO)],
[Declined Offer Forwarded by Agent (NTO)],
[Declined Offer Forwarded by Distributor (NTO)],
[Printed for Paper Delivery by Distributor],
[Printed for Paper Delivery by Agent],
[Printed for Paper Delivery by Consumer],
[Delivery Requirements Received],
[Deleted],
[Consumer Opted Out of Electronic Delivery],
[Printed for Paper Delivery by Carrier],
[Consumer Policy Suspended ],
[Consumer Failed ID Check],
[Consumer Failed Login],
[Reissue Request by Agent],
[Expired])
)piv;
END
GO
GRANT EXECUTE ON  [dbo].[RPT_GetPolicyCountByStatusBySupplierId_HorizontalData] TO [PolicyEXDBReader]
GO
