import 'dart:async';

import 'package:get/get.dart';

typedef StreamUnsub = Future<void> Function();

mixin StreamSubscriptionManager on GetxController {
  final List<StreamSubscription> _streamSubscriptions = [];

  void _onEvent(dynamic event) {
    update();
  }

  StreamUnsub addStream(Stream stream) {
    final subscription = stream.listen(_onEvent);
    _streamSubscriptions.add(subscription);

    return () async {
      _streamSubscriptions.remove(subscription);
      await subscription.cancel();
    };
  }

  List<StreamUnsub> addStreamList(List<Stream> streamList) {
    return streamList.map((e) => addStream(e)).toList();
  }

  Future<void> clearSubscriptions() async {
    final streamSubscriptions = [..._streamSubscriptions];
    _streamSubscriptions.clear();
    await Future.wait(streamSubscriptions.map((e) => e.cancel()));
  }
}
