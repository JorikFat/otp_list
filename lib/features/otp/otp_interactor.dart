import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:otp/otp.dart';
import 'package:otp_list/core/core.dart';
import 'package:otp_list/core/extensions.dart';
import 'package:otp_list/features/otp/domain/duplicate_exception.dart';
import 'package:otp_list/features/otp/domain/otp_controller.dart';
import 'package:otp_list/features/otp/domain/otp_storage.dart';
import 'package:otp_list/features/otp/list/otp_list_model.dart';
import 'package:otp_list/features/otp/list/otp_list_presenter.dart';
import 'package:otp_list/features/otp/otp.dart';
import 'package:otp_list/features/otp/otp_navigator.dart';
import 'package:otp_list/features/timer/indicator/timer_indicator_presenter.dart';
import 'package:otp_list/features/timer/otp_timer.dart';

class OtpInteractor {
  final OtpNavigator navigator;
  final ValueNotifier<bool> isReady = ValueNotifier<bool>(false);
  final OtpController controller = OtpController(OtpStorage(configs));
  late final OtpListPresenter list;
  final indicator = TimerIndicatorPresenter('');
  final OtpTimer timer = OtpTimer();
  final _messages = StreamController<String>.broadcast();

  Stream<String> get messages => _messages.stream;

  OtpInteractor({
    required this.navigator,
  });

  Future<void> start() async {
    await controller.initialize();
    list = OtpListPresenter(_getModelsList());
    timer.listen((count) {
      indicator.update(count);
      if (count == 30) list.update(_getModelsList());
    });
    timer.start();
    isReady.value = true;
  }

  void toScan() async {
    final newCode = await navigator.scan();
    newCode?.let((it) async {
      try {
        final Otp newOtp = await controller.add(it);
        list.add(_fromEntity(newOtp));
      } on DuplicateException {
        log('throw duplicate');
        _messages.add("Такой OTP уже есть в списке");
      }
    });
  }

  List<OtpModel> _getModelsList() => controller.codes.map(_fromEntity).toList();

  OtpModel _fromEntity(Otp entity) {
    final mills = DateTime.now().millisecondsSinceEpoch;
    final code = OTP.generateTOTPCodeString(entity.secret, mills);
    return OtpModel(
      user: entity.email,
      issuer: entity.issuer,
      code: code,
    );
  }
}
