import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_clean_todo/application/auth/auth_service.dart';
import 'package:flutter_clean_todo/flutter/pages/login/login_page_presenter.dart';
import 'package:flutter_clean_todo/getx/presenters/stream_subscription_manager.dart';
import 'package:get/get.dart';

class GetxLoginPresenter extends GetxController
    with StreamSubscriptionManager
    implements LoginPagePresenter {
  final RxBool _isLoggingIn = RxBool(false);
  final Rx<String?> _errorRx = Rx(null);

  final AuthService _authService;

  GetxLoginPresenter(this._authService) {
    addStreamList([_isLoggingIn.stream]);
  }

  @override
  bool get isLoggingIn => _isLoggingIn.value;

  @override
  Future<void> loginWithEmailAndPassword(String email, String password) async {
    try {
      _isLoggingIn.value = true;
      _errorRx.value = null;
      await _authService.loginWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e, s) {
      _errorRx.value = e.message;
    } catch (e, s) {
      print(e);
      print(s);
      _errorRx.value =
          "Something went wrong when trying to login with email and password";
    } finally {
      _isLoggingIn.value = false;
    }
  }

  @override
  Future<void> loginWithGoogle() async {
    try {
      _isLoggingIn.value = true;
      _errorRx.value = null;
      await _authService.loginWithGoogle();
    } on FirebaseAuthException catch (e, s) {
      _errorRx.value = e.message;
    } catch (e, s) {
      print(e);
      print(s);
      _errorRx.value = "Something went wrong when trying to login with google";
    } finally {
      _isLoggingIn.value = false;
    }
  }

  @override
  Stream<String?> get errorStream => _errorRx.stream;

  @override
  void navigateToRegisterPage() {
    Get.toNamed("/register");
  }

  @override
  void dispose() {
    clearSubscriptions();
    super.dispose();
  }
}
