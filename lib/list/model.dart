import 'package:otp/otp.dart';

class OtpItem {
  final String token;
  late final String email;
  late final String _secret;
  late final String issuer;
  String code(int moment) => OTP.generateTOTPCodeString(_secret, moment);
  String codeByTime(DateTime moment) =>
      OTP.generateTOTPCodeString(_secret, moment.microsecondsSinceEpoch);

  OtpItem.fromToken(this.token) {
    Uri uri = Uri.parse(Uri.decodeFull(token));
    email = uri.path.substring(1);
    Map<String, String> params = Uri.splitQueryString(uri.query);
    issuer = params['issuer']!;
    _secret = params['secret']!;
  }
}
