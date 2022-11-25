import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScreen2 extends StatefulWidget {
  static MaterialPageRoute route() =>
      MaterialPageRoute(builder: (_) => const QRScreen2());

  const QRScreen2({super.key});

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<QRScreen2> {
  @override
  Widget build(BuildContext context) => Material(
      child: MobileScanner(
          allowDuplicates: false,
          onDetect: (barcode, args) async {
            if (barcode.rawValue == null) {
              debugPrint('Failed to scan Barcode');
            } else {
              final String code = barcode.rawValue!;
              debugPrint('Barcode found! $code');
              Navigator.pop(context, code);
              // await _showAlertDialog(
              //     code, (data) => Navigator.pop(context, data));
            }
          }));

  Future<String?> _showAlertDialog(
          String qrData, Function(String?) callback) async =>
      await showDialog<String>(
          context: context,
          builder: (_) => AlertDialog(
                title: const Text("QR код распознан"),
                content: Text(qrData),
                actions: [
                  TextButton(
                      onPressed: () => _handleDialog(qrData, callback),
                      child: const Text("Принять")),
                  TextButton(
                      onPressed: () => _handleDialog(null, callback),
                      child: const Text("Отмена"))
                ],
              ));

  void _handleDialog(String? line, Function(String?) callback) {
    Navigator.pop(context, line);
    callback.call(line);
  }
}
