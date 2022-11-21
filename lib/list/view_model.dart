import 'package:bloc/bloc.dart';
import 'package:otp_list/list/model.dart';
import 'package:otp_list/list/storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewModel {
  final Storage _storage;
  List<String> _codes = List.empty();
  final ListCubit itemsCubit = ListCubit();

  ViewModel(SharedPreferences prefs) : _storage = EncryptedStorage(prefs) {
    _codes = _storage.read();
    itemsCubit.init(_codes.map((it) => OtpItem.fromToken(it)).toList());
  }

  void addCode(String code) {
    itemsCubit.add(OtpItem.fromToken(code));
    _storage.save(_codes..add(code));
  }

  void removeCode(OtpItem otpItem) {
    itemsCubit.remove(otpItem);
    _storage.save(_codes..remove(otpItem.code));
  }
}

class ListCubit extends Cubit<List<OtpItem>> {
  ListCubit() : super(List.empty());

  void init(List<OtpItem> codes) => emit(codes);

  void add(OtpItem code) => emit(List.from(state)..add(code));

  void remove(OtpItem code) => emit(List.from(state)..remove(code));
}

abstract class Storage {
  List<String> read();
  void save(List<String> codes);
}
