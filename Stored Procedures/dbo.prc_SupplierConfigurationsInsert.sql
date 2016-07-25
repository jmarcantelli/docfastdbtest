SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_SupplierConfigurationsInsert]
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

	INSERT INTO [SupplierConfigurations]
	(
		[SupplierID],
		[ConfigurationKey],
		[ConfigurationValue],
		[CreatedBy],
		[CreateDate],
		[ModifiedBy],
		[ModifiedDate]
	)
	VALUES
	(
		@SupplierID,
		@ConfigurationKey,
		@ConfigurationValue,
		@CreatedBy,
		@CreateDate,
		@ModifiedBy,
		@ModifiedDate
	)

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_SupplierConfigurationsInsert] TO [PolicyEXDBReader]
GO
