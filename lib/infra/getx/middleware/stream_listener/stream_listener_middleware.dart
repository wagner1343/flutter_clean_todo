import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_stream_listener/flutter_stream_listener.dart';
import 'package:get/get.dart';

abstract class StreamListenerMiddleware<Event> extends GetMiddleware {
  StreamListenerMiddleware();

  void onEvent(Event event);

  Stream<Event> get eventStream;

  @override
  Widget onPageBuilt(Widget page) {
    return StreamListener<Event>(
        stream: eventStream, onData: onEvent, child: page);
  }
}
