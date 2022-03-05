import 'dart:async';

import 'package:flutter/material.dart';

class ColorStream {
  final StreamController<Color?> _controller =
      StreamController<Color?>.broadcast();
  StreamSink<Color?> get sink => _controller.sink;
  Stream<Color?> get stream => _controller.stream;

  void dispose() {
    _controller.close();
  }
}
