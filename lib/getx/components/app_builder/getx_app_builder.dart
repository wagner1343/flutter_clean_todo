import 'package:flutter/widgets.dart';
import 'package:flutter_clean_todo/getx/components/app_builder/getx_app_builder_args.dart';
import 'package:get/get.dart';

class GetxAppBuilder {
  final GetxAppBuilderArgs args;

  GetxAppBuilder(this.args);

  Widget call(BuildContext context) {
    return GetMaterialApp(
      getPages: args.routes,
      title: args.appName,
    );
  }
}
