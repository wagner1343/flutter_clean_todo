import 'package:flutter/widgets.dart';
import 'package:flutter_clean_todo/application/auth/auth_user.dart';
import 'package:flutter_clean_todo/getx/middleware/auth/auth_listener_middleware.dart';
import 'package:get/get.dart';

class GuestOnlyGuard extends AuthListenerMiddleware {
  final String targetRoute;

  GuestOnlyGuard(this.targetRoute, super.authService);

  @override
  RouteSettings? redirect(String? route) {
    return authService.currentUser != null
        ? RouteSettings(name: targetRoute)
        : null;
  }

  @override
  void onAuthUserChanged(AuthUser? user) {
    if (user != null) {
      Get.offAllNamed(targetRoute);
    }
  }
}
