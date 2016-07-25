SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_SupplierConfigurationsDelete]
(
	@SupplierID int,
	@ConfigurationKey nvarchar(100)
)
AS
	SET NOCOUNT ON

	DELETE 
	FROM   [SupplierConfigurations]
	WHERE  
		[SupplierID] = @SupplierID AND
		[ConfigurationKey] = @ConfigurationKey

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_SupplierConfigurationsDelete] TO [PolicyEXDBReader]
GO
