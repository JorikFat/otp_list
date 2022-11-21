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
  Widget build(BuildContext context) => StreamBuilder<List<OtpItem>>(
      initialData: widget._viewModel.itemsCubit.state,
      stream: widget._viewModel.itemsCubit.stream,
      builder: (_, snap) => Padding(
            padding: const EdgeInsets.all(16),
            child: ListView.separated(
                itemCount: widget._viewModel.itemsCubit.state.length,
                separatorBuilder: (_, __) => const SizedBox(height: 16),
                itemBuilder: (_, index) =>
                    OtpWidget(widget._viewModel.itemsCubit.state[index])),
          ));
}

class OtpWidget extends StatelessWidget {
  final OtpItem _otp;

  const OtpWidget(this._otp, {super.key});

  @override
  Widget build(BuildContext context) => Column(children: [
        Row(children: [Text(_otp.email), const Spacer(), Text(_otp.issuer)]),
        const Text("CODE", style: TextStyle(fontSize: 30, color: Colors.black))
      ]);
}
