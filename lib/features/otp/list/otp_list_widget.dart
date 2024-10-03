import 'package:flutter/material.dart';
import 'package:otp_list/features/otp/list/otp_list_model.dart';

class OtpListWidget extends StatelessWidget {
  final List<OtpModel> models;

  const OtpListWidget(this.models, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView.separated(
        itemCount: models.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (_, index) => _OtpWidget(models[index]),
      ),
    );
  }
}

class _OtpWidget extends StatelessWidget {
  final OtpModel model;

  const _OtpWidget(this.model, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(31, 65, 57, 57),
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Text(model.user),
              const Spacer(),
              Text(model.issuer)
            ]),
            Text(
              model.code,
              style: const TextStyle(fontSize: 30, color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
