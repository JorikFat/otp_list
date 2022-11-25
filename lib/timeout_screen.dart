import 'package:flutter/material.dart';

class TimeoutScreen extends StatelessWidget {
  const TimeoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Material(
          child: Column(
        children: [
          Expanded(flex: 1, child: Container()),
          const Expanded(
              flex: 2,
              child: Text("Время для тестирования приложения закончено")),
          Expanded(child: Container())
        ],
      ));
}

bool expireTimeout() =>
    DateTime.now().millisecondsSinceEpoch >
    DateTime(2022, 11, 27).millisecondsSinceEpoch;
