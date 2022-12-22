import 'package:flutter/material.dart';

class FlutterTodoApp extends StatelessWidget {
  final WidgetBuilder appBuilder;

  const FlutterTodoApp({Key? key, required this.appBuilder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return appBuilder(context);
  }
}
