SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_DistributorConfigurationsDelete]
(
	@DistributorID int,
	@ConfigurationKey nvarchar(100)
)
AS
	SET NOCOUNT ON

	DELETE 
	FROM   [DistributorConfigurations]
	WHERE  
		[DistributorID] = @DistributorID AND
		[ConfigurationKey] = @ConfigurationKey

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_DistributorConfigurationsDelete] TO [PolicyEXDBReader]
GO
