SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_SupplierConfigurationsUpdate]
(
	@SupplierID int,
	@ConfigurationKey nvarchar(100),
	@ConfigurationValue nvarchar(max),
	@CreatedBy nvarchar(50),
	@CreateDate datetime,
	@ModifiedBy nvarchar(50),
	@ModifiedDate datetime
)
AS
	SET NOCOUNT ON
	
	UPDATE [SupplierConfigurations]
	SET
		[SupplierID] = @SupplierID,
		[ConfigurationKey] = @ConfigurationKey,
		[ConfigurationValue] = @ConfigurationValue,
		[CreatedBy] = @CreatedBy,
		[CreateDate] = @CreateDate,
		[ModifiedBy] = @ModifiedBy,
		[ModifiedDate] = @ModifiedDate
	WHERE 
		[SupplierID] = @SupplierID AND
		[ConfigurationKey] = @ConfigurationKey

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_SupplierConfigurationsUpdate] TO [PolicyEXDBReader]
GO
