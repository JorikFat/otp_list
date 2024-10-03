import 'dart:async';

class OtpTimer {
  int value = 30;
  final _controller = StreamController<int>();

  Future<void> start() async {
    final nowSeconds = DateTime.now().second;
    value = nowSeconds <= 30 ? nowSeconds : nowSeconds - 30;
    _controller.add(nowSeconds);
    Timer.periodic(const Duration(seconds: 1), (_) {
      value--;
      if (value == 0) value = 30;
      _controller.add(value);
    });
  }

  StreamSubscription listen(
    void Function(int event)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) =>
      _controller.stream.listen(
        onData,
        onError: onError,
        onDone: onDone,
        cancelOnError: cancelOnError,
      );
}
