SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_DistributorConfigurationsUpdate]
(
	@DistributorID int,
	@ConfigurationKey nvarchar(100),
	@ConfigurationValue nvarchar(max),
	@CreatedBy nvarchar(50),
	@CreateDate datetime,
	@ModifiedBy nvarchar(50),
	@ModifiedDate datetime
)
AS
	SET NOCOUNT ON
	
	UPDATE [DistributorConfigurations]
	SET
		[DistributorID] = @DistributorID,
		[ConfigurationKey] = @ConfigurationKey,
		[ConfigurationValue] = @ConfigurationValue,
		[CreatedBy] = @CreatedBy,
		[CreateDate] = @CreateDate,
		[ModifiedBy] = @ModifiedBy,
		[ModifiedDate] = @ModifiedDate
	WHERE 
		[DistributorID] = @DistributorID AND
		[ConfigurationKey] = @ConfigurationKey

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_DistributorConfigurationsUpdate] TO [PolicyEXDBReader]
GO
