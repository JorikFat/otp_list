import 'package:bloc/bloc.dart';
import 'package:otp_list/list/storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewModel {
  final Storage _storage;
  final ListCubit listCubit = ListCubit();

  ViewModel(SharedPreferences prefs) : _storage = EncryptedStorage(prefs) {
    var items = _storage.read();
    listCubit.init(items);
  }

  void addCode(String code) {
    listCubit.add(code);
    _storage.save(listCubit.state);
  }

  void removeCode(String code) {
    listCubit.remove(code);
    _storage.save(listCubit.state);
  }
}

class ListCubit extends Cubit<List<String>> {
  ListCubit() : super(List.empty());

  void init(List<String> codes) => emit(codes);

  void add(String code) => emit(List.from(state)..add(code));

  void remove(String code) => emit(List.from(state)..remove(code));
}

abstract class Storage {
  List<String> read();
  void save(List<String> codes);
}
