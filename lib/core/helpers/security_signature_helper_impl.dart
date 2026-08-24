import 'package:login_biometrics_app/core/helpers/security_signature_helper.dart';
import 'package:uuid/uuid.dart';

class SecuritySignatureHelperImpl implements SecuritySignatureHelper {
  final String apiSecretId;
  final String apiSecretKey;

  SecuritySignatureHelperImpl(
    this.apiSecretId,
    this.apiSecretKey
  );

  @override
  String createNonce() {
    return const Uuid().v4();
  }

  @override
  String generateHmacSignature({
    required String method, 
    required String endpoint, 
    required String timestamp, 
    required String nonce
  }) {
    throw UnimplementedError();
  }

  @override
  String getTimestampMSSinceEpoch() {
    throw UnimplementedError();
  }
  
}