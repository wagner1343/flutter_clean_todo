import 'dart:async';

import 'package:flutter_clean_todo/application/auth/auth_service.dart';
import 'package:flutter_clean_todo/application/auth/auth_user.dart';
import 'package:flutter_clean_todo/getx/middleware/stream_listener/stream_listener_middleware.dart';

abstract class AuthListenerMiddleware
    extends StreamListenerMiddleware<AuthUser?> {
  final AuthService authService;

  AuthListenerMiddleware(this.authService);

  void onAuthUserChanged(AuthUser? user);

  @override
  Stream<AuthUser?> get eventStream => authService.currentUserStream;

  @override
  void onEvent(AuthUser? event) {
    onAuthUserChanged(event);
  }
}
