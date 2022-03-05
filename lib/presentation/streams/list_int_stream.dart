import 'dart:async';

class ListIntStream {
  final StreamController<List<int>> _controller = StreamController<List<int>>();
  StreamSink<List<int>> get sink => _controller.sink;
  Stream<List<int>> get stream => _controller.stream;

  void dispose() {
    _controller.close();
  }
}
