import 'dart:async';

import 'package:flutter/material.dart';

class ErrorStreamToSnackbar extends StatefulWidget {
  final Stream<String?> errorStream;
  final Widget? child;

  const ErrorStreamToSnackbar({required this.errorStream, Key? key, this.child})
      : super(key: key);

  @override
  State<ErrorStreamToSnackbar> createState() => _ErrorStreamToSnackbarState();
}

class _ErrorStreamToSnackbarState extends State<ErrorStreamToSnackbar> {
  StreamSubscription? _streamSubscription;

  @override
  void initState() {
    _streamSubscription = widget.errorStream.listen((e) {
      if (e != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e)));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child ?? Container();
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }
}
