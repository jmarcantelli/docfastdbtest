SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_PolicyUpdate]
(
	@PolicyID bigint,
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
	
	UPDATE [Policy]
	SET
		[SupplierID] = @SupplierID,
		[PolNumber] = @PolNumber,
		[XMLID] = @XMLID,
		[EffectiveDate] = @EffectiveDate,
		[DeliveryDate] = @DeliveryDate,
		[DocuSignID] = @DocuSignID,
		[RawXML] = @RawXML,
		[PolicyStatusID] = @PolicyStatusID,
		[PolicyDeliveryTypeID] = @PolicyDeliveryTypeID,
		[ConsumerName] = @ConsumerName,
		[CreatedBy] = @CreatedBy,
		[CreateDate] = @CreateDate,
		[ModifiedBy] = @ModifiedBy,
		[ModifiedDate] = @ModifiedDate,
		[PremiumAmount] = @PremiumAmount,
		[TransmissionStatus] = @TransmissionStatus
	WHERE 
		[PolicyID] = @PolicyID

	RETURN @@Error
GO
GRANT EXECUTE ON  [dbo].[prc_PolicyUpdate] TO [PolicyEXDBReader]
GO
