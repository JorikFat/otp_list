import 'package:flutter/material.dart';
import 'package:otp/otp.dart';
import 'package:otp_list/qr_camera.dart';
import 'package:otp_list/qr_camera2.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  final _codeController = TextEditingController();
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();

  void _checkCode() {
    final secret = _codeController.text;
    final code = OTP.generateTOTPCodeString(
        secret, DateTime.now().millisecondsSinceEpoch);
    print('code= $code');
  }
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) => Material(
          child: Column(
        children: [
          TextField(controller: widget._codeController),
          const Spacer(),
          TextButton(onPressed: widget._checkCode, child: const Text("Check")),
          TextButton(onPressed: _navigateToQR, child: const Text("Start Scan")),
          TextButton(onPressed: _mobileScan, child: const Text("Mobile Scan"))
        ],
      ));

  void _navigateToQR() {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const QRCamera()));
  }

  void _mobileScan() => Navigator.push(context, QRScreen2.route());
}
