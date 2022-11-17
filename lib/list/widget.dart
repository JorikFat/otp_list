import 'package:flutter/material.dart';
import 'package:otp_list/list/view_model.dart';

class CodesListWidget extends StatefulWidget {
  final ViewModel _viewModel = ViewModel();
  CodesListWidget({super.key});

  void addCode(String code) => _viewModel.addCode(code);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<CodesListWidget> {
  @override
  Widget build(BuildContext context) => StreamBuilder<List<String>>(
      initialData: widget._viewModel.listCubit.state,
      stream: widget._viewModel.listCubit.stream,
      builder: (_, snap) => ListView.builder(
          itemCount: widget._viewModel.listCubit.state.length,
          itemBuilder: (_, index) =>
              Text(widget._viewModel.listCubit.state[index])));
}
