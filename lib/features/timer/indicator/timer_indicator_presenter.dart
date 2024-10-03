import 'package:flutter/material.dart';

class TimerIndicatorPresenter extends ValueNotifier<String> {
  TimerIndicatorPresenter(super.value);

  void update(int count) {
    value = count.toString().padLeft(2, '0');
  }
}
