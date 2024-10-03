import 'package:flutter/material.dart';
import 'package:otp_list/features/timer/indicator/timer_indicator_presenter.dart';
import 'package:otp_list/features/timer/indicator/timer_indicator_widget.dart';

class TimerIndicatorComponent extends StatelessWidget {
  final TimerIndicatorPresenter presenter;

  const TimerIndicatorComponent(this.presenter, {super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
        valueListenable: presenter,
        builder: (context, value, _) {
          return TimerIndicatorWidget(value);
        });
  }
}
