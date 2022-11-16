import 'package:flutter/material.dart';
import 'package:otp/otp.dart';
import 'package:otp_list/qr_camera.dart';

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
          TextButton(onPressed: _mobileScan, child: const Text("Mobile Scan"))
        ],
      ));

  void _mobileScan() async {
    var result = await Navigator.push(context, QRScreen2.route());
    if (result == null) return;
    widget._codeController.text = result as String;
  }
}
