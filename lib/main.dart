import 'package:flutter/material.dart';
import 'package:otp_list/core/consts.dart';
import 'package:otp_list/core/core.dart';
import 'package:otp_list/features/otp/otp_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      home: const OtpScreen(),
    );
  }
}
