import 'package:flutter/foundation.dart';

abstract class RegisterPagePresenter implements Listenable {
  Future<void> registerWithEmailAndPassword(
      String name, String email, String password);

  void navigateToLoginScreen();

  bool get isRegistering;

  Stream<String?> get errorStream;
}
