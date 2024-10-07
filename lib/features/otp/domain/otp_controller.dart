import 'package:otp_list/core/extensions.dart';
import 'package:otp_list/features/otp/domain/duplicate_exception.dart';
import 'package:otp_list/features/otp/domain/otp_storage.dart';
import 'package:otp_list/features/otp/otp.dart';

class OtpController {
  final OtpStorage _storage;
  final List<Otp> codes = [];

  OtpController(this._storage);

  Future<void> initialize() async {
    final savedCodes = await _storage.read();
    savedCodes?.let((it) => codes.addAll(it.map((it) => it.otp)));
  }

  Future<Otp> add(String token) async {
    final Otp newOtp = token.otp;
    if (codes.contains(newOtp)) {
      throw DuplicateException();
    }
    codes.add(newOtp);
    final savedTokens = (await _storage.read()) ?? List.empty();
    _storage.save([...savedTokens, token]);
    return newOtp;
  }
}

extension _StringOtp on String {
  Otp get otp {
    Uri uri = Uri.parse(Uri.decodeFull(this));
    final email = uri.path.substring(1);
    Map<String, String> params = Uri.splitQueryString(uri.query);
    final issuer = params['issuer']!;
    final secret = params['secret']!;
    return Otp(secret: secret, issuer: issuer, email: email);
  }
}
