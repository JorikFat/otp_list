import 'package:flutter/material.dart';

class ScannerNavigator {
  final NavigatorState _navigator;

  ScannerNavigator(BuildContext context) : _navigator = Navigator.of(context);

  void returnCode(String code) {
    _navigator.pop(code);
  }
}
