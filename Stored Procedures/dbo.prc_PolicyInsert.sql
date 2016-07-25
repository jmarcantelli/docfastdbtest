SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_PolicyInsert]
(
	@PolicyID bigint = NULL OUTPUT,
	@SupplierID int,
	@PolNumber nvarchar(100),
	@XMLID nvarchar(100),
	@EffectiveDate datetime = NULL,
	@DeliveryDate datetime = NULL,
	@DocuSignID nvarchar(250) = NULL,
	@RawXML ntext = NULL,
	@PolicyStatusID int = NULL,
	@PolicyDeliveryTypeID int,
	@ConsumerName nvarchar(200) = NULL,
	@CreatedBy nvarchar(50),
	@CreateDate datetime,
	@ModifiedBy nvarchar(50),
	@ModifiedDate datetime,
	@PremiumAmount money = NULL,
	@TransmissionStatus bit
)
AS
	SET NOCOUNT ON

	INSERT INTO [Policy]
	(
		[SupplierID],
		[PolNumber],
		[XMLID],
		[EffectiveDate],
		[DeliveryDate],
		[DocuSignID],
		[RawXML],
		[PolicyStatusID],
		[PolicyDeliveryTypeID],
		[ConsumerName],
		[CreatedBy],
		[CreateDate],
		[ModifiedBy],
		[ModifiedDate],
		[PremiumAmount],
		[TransmissionStatus]
	)
	VALUES
	(
		@SupplierID,
		@PolNumber,
		@XMLID,
		@EffectiveDate,
		@DeliveryDate,
		@DocuSignID,
		@RawXML,
		@PolicyStatusID,
		@PolicyDeliveryTypeID,
		@ConsumerName,
		@CreatedBy,
		@CreateDate,
		@ModifiedBy,
		@ModifiedDate,
		@PremiumAmount,
		@TransmissionStatus
	)

	SELECT @PolicyID = SCOPE_IDENTITY();

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_PolicyInsert] TO [PolicyEXDBReader]
GO
