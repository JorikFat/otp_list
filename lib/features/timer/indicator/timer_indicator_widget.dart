import 'package:flutter/material.dart';

class TimerIndicatorWidget extends StatelessWidget {
  final String count;

  const TimerIndicatorWidget(this.count, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(count);
  }
}
