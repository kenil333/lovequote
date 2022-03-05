import 'dart:async';

import './../../domain/all.dart';

class VideoListStream {
  final StreamController<List<VideoModel>> _controller =
      StreamController<List<VideoModel>>();
  StreamSink<List<VideoModel>> get sink => _controller.sink;
  Stream<List<VideoModel>> get stream => _controller.stream;

  dispose() {
    _controller.close();
  }
}
