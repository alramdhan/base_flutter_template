abstract class SecuritySignatureHelper {
  String getTimestampMSSinceEpoch();
  String createNonce();
  String generateHmacSignature({
    required String method, 
    required String endpoint, 
    required String timestamp, 
    required String nonce
  });
}