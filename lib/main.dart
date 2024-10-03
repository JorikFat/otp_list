import 'package:flutter/material.dart';
import 'package:otp/otp.dart';
import 'package:otp_list/core/consts.dart';
import 'package:otp_list/core/core.dart';
import 'package:otp_list/features/scanner/scanner_screen.dart';
import 'package:otp_list/list/widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'list/view_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configs = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: APP_NAME,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(),
    );
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
  final ViewModel _listViewModel = ViewModel(configs);

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text('TOTP codes')),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(child: CodesListWidget(_listViewModel)),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: _mobileScan,
        tooltip: 'Scan Code',
        child: const Icon(Icons.qr_code),
      ));

  void _mobileScan() async {
    var result = await Navigator.push(context, ScannerScreen.route);
    if (result == null) return;
    _listViewModel.addCode(result as String);
  }
}
