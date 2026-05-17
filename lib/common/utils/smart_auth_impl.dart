import 'package:pinput/pinput.dart';
import 'package:smart_auth/smart_auth.dart';

class SmsRetrieverImpl implements SmsRetriever {
  final SmartAuth smartAuth;
  const SmsRetrieverImpl(this.smartAuth);

  @override
  Future<void> dispose() {
    return smartAuth.removeUserConsentApiListener();
  }

  @override
  Future<String?> getSmsCode() async {
    final res = await smartAuth.getSmsWithRetrieverApi();
    if (res.hasData) {
      final code = res.requireData.code;
      return code;
    }
    return null;
  }

  @override
  bool get listenForMultipleSms => false;
}
