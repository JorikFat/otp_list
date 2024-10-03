import 'package:flutter/material.dart';
import 'package:otp_list/core/consts.dart';
import 'package:otp_list/features/otp/list/otp_list_component.dart';
import 'package:otp_list/features/otp/otp_interactor.dart';
import 'package:otp_list/features/otp/otp_navigator.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<OtpScreen> {
  late final interactor = OtpInteractor(
    navigator: OtpNavigator(context),
  );

  @override
  void initState() {
    super.initState();
    interactor.start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(APP_NAME),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: interactor.toScan,
        tooltip: 'Scan Code',
        child: const Icon(Icons.qr_code),
      ),
      body: ValueListenableBuilder<bool>(
        valueListenable: interactor.isReady,
        builder: (context, value, _) {
          return value
              ? OtpListComponent(interactor.list)
              : const Center(child: Text("Not ready"));
        },
      ),
    );
  }
}
