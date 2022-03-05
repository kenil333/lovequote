import 'dart:async';

class DoubleStream {
  final StreamController<double> _controller =
      StreamController<double>.broadcast();
  StreamSink<double> get sink => _controller.sink;
  Stream<double> get stream => _controller.stream;

  void dispose() {
    _controller.close();
  }
}
