import 'package:bloc/bloc.dart';

class ViewModel {
  final ListCubit listCubit = ListCubit();

  void addCode(String code) => listCubit.add(code);
}

class ListCubit extends Cubit<List<String>> {
  ListCubit() : super(List.empty());

  void add(String code) {
    var oldList = state;
    var newList = List.from(oldList)..add(code);
    emit(List.from(newList));
  }
}
