import 'package:shared_preferences/shared_preferences.dart';

class OtpStorage {
  final SharedPreferences _prefs;

  OtpStorage(this._prefs);

  Future<void> save(List<String> codes) => _prefs.setStringList('codes', codes);

  Future<List<String>?> read() async => _prefs.getStringList('codes');
}
