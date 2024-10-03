import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:otp_list/features/scanner/scanner_interactor.dart';
import 'package:otp_list/features/scanner/scanner_navigator.dart';

class ScannerScreen extends StatefulWidget {
  static MaterialPageRoute get route =>
      MaterialPageRoute(builder: (_) => const ScannerScreen());

  const ScannerScreen({super.key});

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<ScannerScreen> {
  late final interactor = ScannerInteractor(ScannerNavigator(context));

  @override
  Widget build(BuildContext context) {
    return Material(
      child: MobileScanner(
        allowDuplicates: false,
        onDetect: interactor.onScan,
      ),
    );
  }
}
