import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class RedirectSettings {
  final String toName;
  final Object? arguments;

  RedirectSettings({required this.toName, this.arguments});
}

class GetxRedirect extends StatefulWidget {
  final RedirectSettings redirectSettings;
  final WidgetBuilder? placeHolderBuilder;

  const GetxRedirect(
      {Key? key, required this.redirectSettings, this.placeHolderBuilder})
      : super(key: key);

  @override
  State<GetxRedirect> createState() => _GetxRedirectState();
}

class _GetxRedirectState extends State<GetxRedirect> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var routeSettings = widget.redirectSettings;
      Get.offAndToNamed(routeSettings.toName,
          arguments: routeSettings.arguments);
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.placeHolderBuilder?.call(context) ?? Container();
  }
}
