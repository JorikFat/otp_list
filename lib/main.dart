import 'package:flutter/material.dart';
import 'package:otp/otp.dart';
import 'package:otp_list/list/widget.dart';
import 'package:otp_list/qr_camera.dart';

import 'list/view_model.dart';

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
  final ViewModel _listViewModel = ViewModel();

  @override
  Widget build(BuildContext context) => Material(
          child: SafeArea(
              child: Column(
        children: [
          TextField(controller: widget._codeController),
          Expanded(child: CodesListWidget(_listViewModel)),
          TextButton(onPressed: widget._checkCode, child: const Text("Check")),
          TextButton(onPressed: _mobileScan, child: const Text("Mobile Scan"))
        ],
      )));

  void _mobileScan() async {
    var result = await Navigator.push(context, QRScreen2.route());
    if (result == null) return;
    _listViewModel.addCode(result as String);
  }
}
