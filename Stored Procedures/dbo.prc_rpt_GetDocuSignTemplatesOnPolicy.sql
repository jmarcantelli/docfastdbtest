SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[prc_rpt_GetDocuSignTemplatesOnPolicy]
(
	@PolNumber		Varchar(250),
	@SupplierID		Int
)
AS
BEGIN
	Select	st.TemplateID, pa.FileName, [Template] = st.Description, st.TemplateUniqueID
	From	Policy p
			Inner Join PolicyAttachment pa on pa.PolicyID = p.PolicyID
			Inner Join SupplierTemplates st on st.SupplierTemplateID = pa.SupplierTemplateID
	Where	p.PolNumber = @PolNumber and
			p.SupplierID = @SupplierID
END
GO
GRANT EXECUTE ON  [dbo].[prc_rpt_GetDocuSignTemplatesOnPolicy] TO [PolicyEXDBReader]
GO
