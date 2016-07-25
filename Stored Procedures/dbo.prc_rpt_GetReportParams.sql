SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[prc_rpt_GetReportParams]
(
	@ProcName		Varchar(500)
)
AS
BEGIN
	Select	PARAMETER_NAME, DATA_TYPE
	From	information_schema.parameters 
	Where	specific_name	=	@ProcName 
END
GO
GRANT EXECUTE ON  [dbo].[prc_rpt_GetReportParams] TO [PolicyEXDBReader]
GO
