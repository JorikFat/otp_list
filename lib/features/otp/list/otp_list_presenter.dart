import 'package:flutter/material.dart';
import 'package:otp_list/features/otp/list/otp_list_model.dart';

class OtpListPresenter extends ValueNotifier<List<OtpModel>> {
  OtpListPresenter(super.value);

  void update(List<OtpModel> models) {
    value = models;
  }

  void add(OtpModel model) {
    value = List.from(value)..add(model);
  }
}
