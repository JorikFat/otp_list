import 'package:flutter/material.dart';
import 'package:otp_list/features/scanner/scanner_screen.dart';

class OtpNavigator {
  final NavigatorState _navigator;

  OtpNavigator(BuildContext context) : _navigator = Navigator.of(context);

  Future<String?> scan() async {
    String? res = (await _navigator.push(ScannerScreen.route)) as String?;
    return res;
  }
}
