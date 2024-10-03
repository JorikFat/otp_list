import 'package:flutter/material.dart';
import 'package:otp_list/features/otp/list/otp_list_model.dart';
import 'package:otp_list/features/otp/list/otp_list_presenter.dart';
import 'package:otp_list/features/otp/list/otp_list_widget.dart';

class OtpListComponent extends StatelessWidget {
  final OtpListPresenter presenter;

  const OtpListComponent(this.presenter, {super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<OtpModel>>(
      valueListenable: presenter,
      builder: (context, value, _) => OtpListWidget(value),
    );
  }
}
