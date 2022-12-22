import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

class PostFrameCallback extends StatefulWidget {
  final FrameCallback callback;
  final Widget? child;
  const PostFrameCallback(
      {Key? key, required this.callback, required this.child})
      : super(key: key);

  @override
  State<PostFrameCallback> createState() => _PostFrameCallbackState();
}

class _PostFrameCallbackState extends State<PostFrameCallback> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(widget.callback);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child ?? Container();
  }
}
