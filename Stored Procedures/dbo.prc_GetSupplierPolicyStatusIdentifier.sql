SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[prc_GetSupplierPolicyStatusIdentifier]  
(  
	@PolicyID	BigInt,
	@PolicyStatusID int
)  
AS  
Begin
	Declare	@SupplierID				Int
	Declare	@KeyName				nVarchar(200)
	Declare	@KeyValue				nVarchar(200)
	Declare	@IdentifyingValue		nVarchar(200)
	Declare	@PolicyStatusIdentifier	nVarchar(200)
	Declare	@PolicyDistributorID	Int

	Select	@PolicyStatusIdentifier = ''
	
	Select	@SupplierID = SupplierID
	From	policy (Nolock)
	Where	PolicyID = @PolicyID

	DECLARE SupplierPolicyStatus_Cursor CURSOR FOR	Select	KeyName, KeyValue, IdentifyingValue
										From	SupplierPolicyStatusIdentifier (Nolock)
										Where	SupplierID = @SupplierID
												and PolicyStatusID = @PolicyStatusID
										Order By PreferenceOrder ASC

	OPEN SupplierPolicyStatus_Cursor   
	FETCH NEXT FROM SupplierPolicyStatus_Cursor INTO @KeyName, @KeyValue, @IdentifyingValue
	WHILE @@FETCH_STATUS = 0   
	BEGIN
		If	@KeyName = 'ConsumerSignerStatusId'
			and Exists(Select * From ConsumerRecipient (Nolock) Where PolicyID = @PolicyID and SignerStatusID = Convert(Int, @KeyValue))
		Begin
			Select	@PolicyStatusIdentifier = @IdentifyingValue
			Break
		End

		If	@KeyName = 'PrintFromHomeOffice' and
			Exists(Select * From SupplierConfigurations (Nolock) Where SupplierID = @SupplierID and ConfigurationKey = 'PrintFromHomeOffice' and ConfigurationValue = @KeyValue) and
			Not Exists(	Select *
						From	PolicyDistributor pd (Nolock) 
								Inner Join SupplierDistributorConfigurations sdc (Nolock) on sdc.DistributorID = pd.DistributorID and sdc.SupplierID = @SupplierID
						Where	pd.PolicyID = @PolicyID and pd.DistributionOrder = 1 and  sdc.Configurationvalue <> @KeyValue)
		Begin
			Select	@PolicyStatusIdentifier = @IdentifyingValue
			Break
		End

		FETCH NEXT FROM SupplierPolicyStatus_Cursor INTO @KeyName, @KeyValue, @IdentifyingValue
	End

	CLOSE SupplierPolicyStatus_Cursor   
	DEALLOCATE SupplierPolicyStatus_Cursor 

	Select	PolicyStatusIdentifier = @PolicyStatusIdentifier
End

GO
GRANT EXECUTE ON  [dbo].[prc_GetSupplierPolicyStatusIdentifier] TO [PolicyEXDBReader]
GO
