import 'dart:async';

import 'package:flutter/material.dart';
import 'package:otp_list/list/model.dart';
import 'package:otp_list/list/view_model.dart';

class CodesListWidget extends StatefulWidget {
  final ViewModel _viewModel;
  const CodesListWidget(this._viewModel, {super.key});

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<CodesListWidget> {
  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 30), (_) {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<List<OtpItem>>(
      initialData: widget._viewModel.itemsCubit.state,
      stream: widget._viewModel.itemsCubit.stream,
      builder: (_, snap) => Padding(
          padding: const EdgeInsets.all(16),
          child: ListView.separated(
              itemCount: widget._viewModel.itemsCubit.state.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (_, index) =>
                  OtpWidget(widget._viewModel.itemsCubit.state[index]))));
}

class OtpWidget extends StatelessWidget {
  final OtpItem _otp;

  const OtpWidget(this._otp, {super.key});

  @override
  Widget build(BuildContext context) => Container(
      decoration: const BoxDecoration(
          color: Color.fromARGB(31, 65, 57, 57),
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Padding(
          padding: const EdgeInsets.all(16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Text(_otp.email),
              const Spacer(),
              Text(_otp.issuer)
            ]),
            Text(_otp.codeByTime(DateTime.now()),
                style: const TextStyle(fontSize: 30, color: Colors.black))
          ])));
}
