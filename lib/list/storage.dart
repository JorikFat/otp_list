import 'package:otp_list/list/view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EncryptedStorage extends Storage {
  static const _CODES = 'codes';
  final SharedPreferences _prefs;

  EncryptedStorage(this._prefs);

  @override
  List<String> read() {
    return _prefs.getStringList(_CODES) ?? List.empty();
  }

  @override
  void save(List<String> codes) => _prefs.setStringList(_CODES, codes);
}
