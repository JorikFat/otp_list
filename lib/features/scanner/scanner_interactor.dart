import 'dart:developer';

import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:otp_list/features/scanner/scanner_navigator.dart';

class ScannerInteractor {
  final ScannerNavigator _navigator;

  ScannerInteractor(this._navigator);

  void onScan(Barcode barcode, MobileScannerArguments? args) {
    if (barcode.rawValue == null) {
      log('Failed to scan Barcode');
    } else {
      final String code = barcode.rawValue!;
      log('Barcode found! $code');
      _navigator.returnCode(code);
    }
  }
}
