import 'package:flutter/foundation.dart';

abstract class LoginPagePresenter implements Listenable {
  Future<void> loginWithEmailAndPassword(String email, String password);
  Future<void> loginWithGoogle();
  void navigateToRegisterPage();
  Stream<String?> get errorStream;
  bool get isLoggingIn;
}
