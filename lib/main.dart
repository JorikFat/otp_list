import 'package:flutter/material.dart';
import 'package:otp/otp.dart';
import 'package:otp_list/list/widget.dart';
import 'package:otp_list/qr_camera.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'list/view_model.dart';

late final SharedPreferences configs;

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
        home: const InitScreen());
  }
}

class InitScreen extends StatefulWidget {
  const InitScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _InitState();
}

class _InitState extends State<InitScreen> {
  @override
  void initState() {
    super.initState();
    asyncInit();
  }

  void asyncInit() async {
    SharedPreferences.getInstance().then((value) {
      configs = value;
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => MyHomePage()));
    });
  }

  @override
  Widget build(BuildContext context) =>
      const Material(child: Center(child: CircularProgressIndicator()));
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
