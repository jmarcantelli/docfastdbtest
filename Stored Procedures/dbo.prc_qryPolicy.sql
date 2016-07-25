SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create procedure [dbo].[prc_qryPolicy] 
(@p0 int,@p1 smallint,@p2 int,@p3 int,@p4 nvarchar(2))
as
--',@p0=54,@p1=3,@p2=54,@p3=54,@p4=N'25'
/*
declare @p0 int
declare @p1 smallint
declare @p2 int
declare @p3 int
declare @p4 nvarchar(2)
set @p0=54
set @p1=3
set @p2=54
set @p3=54
set @p4='25'
*/
SELECT DISTINCT [t3].[PolicyID], [t3].[SupplierID], [t3].[PolNumber], [t3].[XMLID], [t3].[EffectiveDate], [t3].[DeliveryDate], [t3].[DocuSignID], CONVERT(NVarChar(MAX),[t3].[RawXML]) AS [RawXML], [t3].[PolicyStatusID], [t3].[PolicyDeliveryTypeID], [t3].[ConsumerName], [t3].[CreatedBy], [t3].[CreateDate], [t3].[ModifiedBy], [t3].[ModifiedDate], [t3].[PremiumAmount], [t3].[TransmissionStatus], [t3].[value], [t3].[value2]
FROM (
    SELECT [t0].[PolicyID], [t0].[SupplierID], [t0].[PolNumber], [t0].[XMLID], [t0].[EffectiveDate], [t0].[DeliveryDate], [t0].[DocuSignID], [t0].[RawXML], [t0].[PolicyStatusID], [t0].[PolicyDeliveryTypeID], [t0].[ConsumerName], [t0].[CreatedBy], [t0].[CreateDate], [t0].[ModifiedBy], [t0].[ModifiedDate], [t0].[PremiumAmount], [t0].[TransmissionStatus], @p0 AS [value], @p1 AS [value2], [t2].[PolicyID] AS [PolicyID2], [t2].[UserID], [t1].[PolicyID] AS [PolicyID3], [t1].[UserID] AS [UserID2]
    FROM [dbo].[Policy] AS [t0], [dbo].[PolicyUser] AS [t1], [dbo].[PolicyAlert] AS [t2]
    ) AS [t3]
WHERE ([t3].[PolicyID2] = ([t3].[PolicyID])) AND ([t3].[UserID] = @p2) AND ([t3].[PolicyID3] = [t3].[PolicyID]) AND ([t3].[UserID2] = @p3) AND (NOT ((CONVERT(NVarChar,[t3].[PolicyStatusID])) IN (@p4)))
GO
GRANT EXECUTE ON  [dbo].[prc_qryPolicy] TO [PolicyEXDBReader]
GO
