SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_DistributorConfigurationsInsert]
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

	INSERT INTO [DistributorConfigurations]
	(
		[DistributorID],
		[ConfigurationKey],
		[ConfigurationValue],
		[CreatedBy],
		[CreateDate],
		[ModifiedBy],
		[ModifiedDate]
	)
	VALUES
	(
		@DistributorID,
		@ConfigurationKey,
		@ConfigurationValue,
		@CreatedBy,
		@CreateDate,
		@ModifiedBy,
		@ModifiedDate
	)

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_DistributorConfigurationsInsert] TO [PolicyEXDBReader]
GO
